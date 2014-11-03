class Post < ActiveRecord::Base
  scope :published, -> {where("publish = ? AND publish_date <= ?", true, Date.today)}
  scope :unpublished, -> {where(publish: false)}
  scope :country, ->(country) { where(:country_classification => country) if country.present?}
  scope :classify, ->(classification) { where(:classification => classification) if classification.present?}

  mount_uploader :image, ImageUploader

  extend Enumerize
  extend ActiveModel::Naming

  validates :title, presence: true, length: {maximum: 50}
  validates :source_date, presence: true
  validates :source, presence: true

  # Association

  belongs_to :user, dependent: :destroy

  enumerize :classification,
    in: %w[culture economics internation medical tech education travel]

  enumerize :country_classification,
    in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey Other]

  before_save :set_user_id

  def self.search(options)
    posts = self.classify(options[:classification])
                .country(options[:country_classification])
    if options[:search].present?
       posts = posts.where('title LIKE ? OR content LIKE ?', "%#{options[:search]}%", "%#{options[:search]}%")
    end
    posts
  end

  def set_user_id
    self.user_id ||= User.current.id
  end

end
