class Post < ActiveRecord::Base
  scope :published, -> {where("publish = ? AND publish_date <= ?", true, Date.today)}
  scope :unpublished, -> {where(publish: false)}
  scope :country, ->(country) { where(:country_classification => country) if country.present?}
  
  mount_uploader :image, ImageUploader

  extend Enumerize
  extend ActiveModel::Naming

  validates :title, presence: true, length: {maximum: 50}
  validates :source_date, presence: true
  validates :source, presence: true

  # Association 

  has_many :taggings
  has_many :tags, through: :taggings

  belongs_to :user

  enumerize :classification,
    in: %w[culture economics internation medical tech education travel]

  enumerize :country_classification,
    in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey Other]

  before_save :set_user_id

end
