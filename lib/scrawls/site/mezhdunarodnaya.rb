module Hezhdunarodnaya
  class Mezhduna
    def self.scrap_top_news(top_news_data, result, url)
      top_news = {}
      top_news[:title] = top_news_data.css("#mainNewsItemTitle").text.strip
      top_news[:description] = top_news_data.css(".b-news-item__desc").text.strip
      if top_news_data.at_css(".b-news-item__media img").present?
        top_news[:image] = top_news_data.at_css(".b-news-item__media img")['src']
      end
      top_news[:source] = absolute_link(url, top_news_data.at_css("a")['href'])
      top_news[:released_date] = Date.today
      result.push(top_news)
    end

    def self.scrap_other_news(news_data, result, url)
      news_data.each do |element_data|
        news_element = {}
        if element_data.css(".b-news-item__title span").present?
          news_element[:title] = element_data.css(".b-news-item__title span").text.strip
        else
          news_element[:title] = element_data.css(".b-news-item__title").text.strip
        end
        if element_data.css('.b-news-item__desc').present?
          news_element[:description] = element_data.css(".b-news-item__desc").text.strip
        end
        if element_data.at_css(".b-news-item__media img")
          news_element[:image]= element_data.at_css(".b-news-item__media img")['src']
        end
        news_element[:source] = absolute_link( url, element_data.at_css("a")['href'])
        news_element[:released_date] = Date.today
        result.push(news_element)
      end
    end

    def self.absolute_link(url, link)
      return url+"/"+ link.split("/").last
    end
  end

  def mezhdunarodnaya_scraping(data, url)
    @result = []
    @url = url
    top_news_data = data.at_css(".b-news-item__content")
    other_news_data = data.css(".b-news-item__content")[1..10]
    # 先爬頭條
    Mezhduna::scrap_top_news(top_news_data, @result, @url)
    # 再爬其他
    Mezhduna::scrap_other_news(other_news_data, @result,@url)
    return @result
  end

end
