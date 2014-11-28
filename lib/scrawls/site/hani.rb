module Hani
  class HaniNews
    def self.scrap_top_news(top_news_data, result,url)
        top_news = {}
        top_news[:title] = top_news_data.at_css(".main-title img")['alt']
        top_news[:description] = top_news_data.at_css(".preface-title").text.strip.gsub(/\r/, "").gsub(/\n/, " ")
        top_news[:image] = top_news_data.at_css(".photo img")['src']
        top_news[:source] = url+top_news_data.at_css("a")['href']
        top_news[:released_date] =Date.today
        result.push(top_news)
    end
    def self.scrap_thumb_news(thumb_news_data, result, url)
      thumb_news_data.each do |news_element|
        thumb_news = {}
        thumb_news[:title] = news_element.at_css("p strong").text
        thumb_news[:description] = news_element.at_css("p").children[1..-1].text
        thumb_news[:source] = url + news_element.at_css("a")['href']
        thumb_news[:image] = Nokogiri::HTML(open(thumb_news[:source])).at_css(".photo-view-area img")['src']
        thumb_news[:released_date] =Date.today
        result.push(thumb_news)
      end

      
    end
  end

  def hani_scraping(data, url)
    @result =[]
    top_news_data = data.at_css(".type1")
    thumb_news_data = data.css(".thumbnail-article-list li")
    HaniNews::scrap_top_news(top_news_data, @result, url)
    HaniNews::scrap_thumb_news(thumb_news_data, @result, url)
    return @result
  end
end