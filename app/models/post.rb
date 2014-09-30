class Post < ActiveRecord::Base
  validates :title, presence: true, length: {maximum: 50}
  extend Enumerize
  extend ActiveModel::Naming

  enumerize :country_classification, 
  in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey]
  belongs_to :user

  def render_title
    if country_classification.present?
      "【#{country_classification.text}】 #{title}"
    else
      "【尚未分類】 #{title}"
    end
    
  end
end
