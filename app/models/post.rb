require "googl"

class Post < ActiveRecord::Base
  scope :published, -> {where("publish = ? AND complete =? AND publish_date <= ?", true, true, Date.today)}
  scope :unpublished, -> {where(publish: false)}
  scope :ready, -> {where("publish = ? AND complete =? ", false, true)}
  scope :country, ->(country) { where(:country_classification => country) if country.present?}
  scope :classify, ->(classification) { where(:classification => classification) if classification.present?}

  mount_uploader :image, ImageUploader

  extend Enumerize
  extend ActiveModel::Naming

  validates :title, presence: true, length: {maximum: 50}
  validates :source_date, presence: true
  validates :source, presence: true

  # Association

  belongs_to :user

  enumerize :classification,
    in: %w[ society comment internation culture economics medical tech education travel sport other]

  enumerize :country_classification,
    in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey Other]

  enumerize :complete,
  in: {complete: true, not_yet: false}


  before_save :set_user_id
  before_save :short_url

  def self.search(options)
    posts = self.classify(options[:classification])
                .country(options[:country_classification])
    if options[:search].present?
       posts = posts.where('title LIKE ? OR content LIKE ?', "%#{options[:search]}%", "%#{options[:search]}%")
    end
    posts
  end

  private

  def set_user_id
    self.user_id ||= User.current.id
  end

  def short_url
    unless source.include?("http://goo.gl/")
      url = Googl.shorten(source)
      self.source = url.short_url
    end
  end

end
