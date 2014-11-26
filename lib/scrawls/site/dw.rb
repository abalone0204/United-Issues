module DW
  class DWNews
    def self.scrap_top_news(top_news_data, result, url)
      top_news = {}
      top_news[:title] = top_news_data.css(".teaserContentWrap").css("h2").text.strip
      top_news[:description] = top_news_data.css(".teaserContentWrap").at_css("p").text.strip
      top_news[:image] = absolute_link( url, top_news_data.at_css(".teaserImg img")['src'])
      top_news[:source] = absolute_link( url, top_news_data.at_css('a')['href'])
      top_news[:released_date] = Date.today
      result.push(top_news)
    end
    def self.absolute_link(url, link)
      return url+ link
    end
  end
  def dw_scraping(data, url)
    result = []
    @url = url
    top_news_data = data.at_css('.imgTeaserL')
    # other_news_data = data.css(".b-news-item__content")[1..10]
    # 先爬頭條
    DWNews::scrap_top_news(top_news_data, result, @url)
    # # 再爬其他
    # Mezhduna::scrap_other_news(other_news_data, @result,@url)
    return result
  end
end
