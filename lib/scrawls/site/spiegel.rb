module Spiegel
  module_function
  class SpiegelNews
    def self.scrap_top_news(data, result, url)
      top_news = {}
      top_news[:title] = Spiegel.get_title(data)
      top_news[:description] = Spiegel.get_description(data)
      top_news[:image] = Spiegel.get_image(data)
      top_news[:source] = Spiegel.get_source(data, url)
      top_news[:released_date] = Date.today
      result.push(top_news)
    end
    def self.scrap_other_news(data, result, url)
      data.each do |element|
        news = {}
        news[:title] = Spiegel.get_title(element)
        news[:description] = Spiegel.get_description(element)
        news[:image] = Spiegel.get_image(element)
        news[:source] = Spiegel.get_source(element, url)
        news[:released_date] = Date.today
        result.push(news)
      end
    end
  end
  def spiegel_scraping(data, url)
    @result = []
    @url = url
    top_news_data = data.at_css(".hp-first-article")
    other_news_data = data.css(".teaser")[1..-1]
    # 先爬頭條
    SpiegelNews::scrap_top_news(top_news_data, @result, @url)
    # 再爬其他
    SpiegelNews::scrap_other_news(other_news_data, @result,@url)
    return @result
  end
  def get_title(obj)
    return obj.at_css(".article-title").text.strip
  end
  def get_description(obj)
    return obj.at_css(".article-intro").text.strip.truncate(250)
  end
  def get_image(obj)
    if obj.at_css("img").present?
      return obj.at_css("img")[:src]  
    end
  end

  def get_source(obj, url)
    return url+obj.at_css("a")[:href]
  end
end
