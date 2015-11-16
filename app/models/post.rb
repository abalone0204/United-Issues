require "googl"
require "csv"
class Post < ActiveRecord::Base
  scope :published, -> {where("publish = ? AND complete =? AND publish_date <= ?", true, true, DateTime.current)}
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
  belongs_to :found_post
  belongs_to :user, :counter_cache => true

  enumerize :classification,
    in: %w[ united_college society comment internation culture economics environment medical tech education travel sport localization other]

  enumerize :country_classification,
    in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey Other]

  enumerize :complete,
  in: {complete: true, not_yet: false}


  before_save :set_user_id
  #before_save :short_url
  after_create :set_found_post_translated

  def self.search(options)
    posts = self.classify(options[:classification])
                .country(options[:country_classification])
    if options[:search].present?
       posts = posts.where('title LIKE ? OR content LIKE ?', "%#{options[:search]}%", "%#{options[:search]}%")
    end
    posts
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |post|
        csv << post.attributes.values_at(*column_names)
      end
    end
  end

  private

  def set_found_post_translated
    if found_post.present?
      self.found_post.update_attribute(:translated, true)  
    end
  end

  def set_user_id
    self.user_id ||= User.current.id
  end

  # def short_url
  #   unless source.include?("http://goo.gl/")
  #     url = Googl.shorten(source)
  #     self.source = url.short_url
  #   end
  # end

end
