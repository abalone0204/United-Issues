class Admin::Finder < Finder
  def get_daily_news
    if found_posts.present?
      check_news
    end
    if found_posts.blank? || self.found_posts.first.released_date < Date.today
      finder = self
      mantis = Mantis.new(self)
      result = mantis.scraping_result
      import_data_to_found_posts(finder, result)
    end
  end

end
