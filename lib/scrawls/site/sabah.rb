module Sabah
  class SabahNews
    def self.scrap_top_news(top_news_data, result)
        urls = top_news_data.css("a").map{|a| a['href']}
        urls[0..3].each do|url|
          top_news = {}
          data = Nokogiri::HTML(open(url)).css(".detay")
          top_news[:title] = data.css("h1").text
          top_news[:source] = url
          top_news[:description] = data.css(".spot").text
          top_news[:released_date] = Date.today
          if data.at_css(".iBox img").present?
            top_news[:image]= data.at_css(".iBox img")['src']  
          end
          
          result.push(top_news)
        end
    end

    def self.scrap_featured_news(featured_news_data, result, url)
      featured_news_data.each do|news_element|
        featured_news = {}
        featured_news[:title] = news_element.at_css("span").text
        featured_news[:description] = news_element.at_css("strong").text
        featured_news[:image] = news_element.at_css("img")['src']
        featured_news[:source] = url+news_element.at_css("a")['href']
        featured_news[:released_date] =Date.today
        result.push(featured_news)
      end
    end
  end
  def sabah_scraping(data, url)
    result = []
    @url = url
    top_news_data = data.css(".mansetSlider li")
    featured_news_data = data.css(".highLinks li")

    # featured_news_data = data.css(".imgTeaserS")
    # other_news_data = data.css(".news")[0..10]

    # 先爬頭條
    SabahNews::scrap_top_news(top_news_data, result)
    # 再爬次要頭條
    SabahNews::scrap_featured_news(featured_news_data, result, @url)
    # DWNews::scrap_featured_news(featured_news_data, result, assets_url)
    # # 再爬其他新聞
    # DWNews::scrap_other_news(other_news_data, result, assets_url)
    # # Mezhduna::scrap_other_news(other_news_data, @result,@url)
    return result
  end
  
  
end