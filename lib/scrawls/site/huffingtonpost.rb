
module HuffingtonPost
  class Huffington
    def self.simple_strip(text)
      return text.strip.gsub(/\t/,"").gsub(/\n/, " ")
    end
    
    def self.scrap_top_news(top_news_data, result)
      top_news = {}
      top_news[:title] = simple_strip(top_news_data.css("h1").text)
      top_news[:description] = simple_strip(top_news_data.css("#sub_headline_preview").text)
      top_news[:image] = top_news_data.at_css("#headline_image")['src']
      top_news[:source] = top_news_data.at_css('a')['href']
      top_news[:released_date] = Date.today
      result.push(top_news)
    end

    def self.scrap_other_news(news_data, result)
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
    end
  end

  def huffington_scraping(data)
    @result = []
    news_data = data.css(".entry")
    top_news_data = news_data.shift
    # 先爬頭條
    Huffington::scrap_top_news(top_news_data, @result)
    # 再爬其他
    Huffington::scrap_other_news(news_data, @result)

    return @result
  end


end
