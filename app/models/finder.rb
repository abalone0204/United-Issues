require 'mantis'

class Finder < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  enumerize :site_url,
    in: ["http://www.huffingtonpost.jp" , 
         "http://itar-tass.com/mezhdunarodnaya-panorama",
         "http://www.dw.de/themen/s-9077"]
  enumerize :country_classification,
    in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey Other]
  enumerize :available,
    in: {active: true, inactive: false}

  # Association
  has_many :found_posts, dependent: :destroy

  #  Validation
  validates_uniqueness_of :site_url

  # Callback
  # after_save :check_country

  def get_daily_news(user)
    if found_posts.present?
      check_news
    end
    if found_posts.blank? || self.found_posts.first.released_date < Date.today
      finder = self
      mantis = Mantis.new(self)
      result = mantis.scraping_result
      import_data_to_found_posts(finder, result)
      user.gg_point += 1
      user.save
    end
  end

  private


  def check_news
    self.found_posts.where("created_at <= ?", Date.today-7).destroy_all
  end


  def import_data_to_found_posts(finder, result)
    result.each do |element|
      finder.found_posts.create(element)
    end
  end

end
