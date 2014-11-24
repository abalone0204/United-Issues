class Finder < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  enumerize :site_url, 
  in: ["http://www.huffingtonpost.jp"]
  enumerize :country_classification,
    in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey Other]
  enumerize :available,
  in: {active: true, inactive: false}
  #  Validation
  validates_uniqueness_of :site_url

  # Callback
  # after_save :check_country
  
  private

  # def check_country
  #   if site_url.end_with?(".jp")
  #     self.country_classification ='Japan'
  #     self.save
  #   end
  # end
end
