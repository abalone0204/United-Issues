module Hani
  class HaniNews
    def self.scrap_top_news(top_news_data, url)
      top_news = {}
        top_news[:title] = top_news_data.at_css(".main-title img")['alt']
        top_news[:description] = top_news_data.at_css(".preface-title").text.strip.gsub(/\r/, "").gsub(/\n/, " ")
        top_news[:image] = top_news_data.at_css(".photo img")['src']
        top_news[:source] = url+top_news_data.at_css("a")['href']
        top_news[:released_date] =Date.today
        result.push(top_news)

      
    end
  end

  def self.hani_scraping(data, url)
    top_news_data = data.at_css(".type1")
    HaniNews::scrap_top_news(top_news_data, url)
  end
end