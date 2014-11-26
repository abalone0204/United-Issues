require_relative '../../lib/scrawls/huffingtonpost'

class Finder < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  enumerize :site_url,
    in: ["http://www.huffingtonpost.jp"]
  enumerize :country_classification,
    in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey Other]
  enumerize :available,
    in: {active: true, inactive: false}

  # Association
  has_many :found_posts

  #  Validation
  validates_uniqueness_of :site_url

  # Callback
  # after_save :check_country
  def get_daily_news
    if found_posts.present?
      check_news
    end
    if found_posts.blank? || found_posts.first.released_date < Date.today
      @finder = self
      if site_url == "http://www.huffingtonpost.jp"
        scrawl_for_huffington(@finder)
      end
    end

  end

  private

  def scrawl_for_huffington(finder)
    result= []
    url = finder.site_url
    data = Nokogiri::HTML(open(url))
    news_data = data.css(".entry")
    top_news_data = news_data.shift
    # 先爬頭條
    top_news = {}
    top_news[:title] = simple_strip(top_news_data.css("h1").text)
    top_news[:description] = simple_strip(top_news_data.css("#sub_headline_preview").text)
    top_news[:image] = top_news_data.at_css("#headline_image")['src']
    top_news[:source] = top_news_data.at_css('a')['href']
    top_news[:released_date] = Date.today
    result.push(top_news)
    # finder.found_posts.create(top_news)
    # 再爬其他
    news_data[1..15].each do |news_data_element|
      news_element = {}
      if news_data.first.css("h4").blank?
        news_element[:title] =  simple_strip(news_data_element.css("h3").text)
        news_element[:source] = news_data_element.at_css("h3 a")['href']
      else
        news_element[:title] = simple_strip(news_data.first.css("h4").text)
        news_element[:source] = news_data_element.at_css("h4 a")['href']
      end
      if news_data_element.at_css(".blogger_name a").present?
        news_element[:original_author] = news_data_element.at_css(".blogger_name a").text
      end
      if news_data_element.at_css("p")
        news_element[:description] = news_data_element.at_css("p").text
      end
      if news_data_element.at_css(".image_wrapper img").present?
        news_element[:image] =news_data_element.at_css(".image_wrapper img")['src']  
      end
      news_element[:released_date] = Date.today
      result.push(news_element)
    end
    import_data_to_found_posts(finder, result)
  end

  def check_news
    self.found_posts.where("created_at <= ?", Date.today-7).destroy_all
  end

  def simple_strip(text)
    return text.strip.gsub(/\t/,"").gsub(/\n/, " ")
  end

  def import_data_to_found_posts(finder, result)
    result.each do |element|
      finder.found_posts.create(element)
    end
  end

end
