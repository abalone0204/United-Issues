class Post < ActiveRecord::Base
  scope :published, -> {where(publish: true)}
  
  extend Enumerize
  extend ActiveModel::Naming

  validates :title, presence: true, length: {maximum: 50}

  # Association 

  has_many :taggings
  has_many :tags, through: :taggings

  belongs_to :user

  enumerize :country_classification,
    in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey]


  # Tagging
  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("tags.id, taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
    # end of tagging

end
