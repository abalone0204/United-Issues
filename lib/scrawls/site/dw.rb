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

    def self.scrap_featured_news(featured_news_data, result, url)
      featured_news_data.each do|element_data|
        news_element = {}
        news_element[:title] = element_data.css(".teaserContentWrap").css("h2").text.strip
        news_element[:image] = absolute_link( url, element_data.at_css(".teaserImg img")['src'])
        news_element[:source] = absolute_link( url, element_data.at_css('a')['href'])
        news_element[:released_date] = Date.today
        result.push(news_element)
      end
    end

    def self.scrap_other_news(other_news_data, result, url)
      other_news_data.each do|element_data|
        news_element ={}
        news_element[:title]= element_data.at_css("h2").text.strip
        news_element[:description] = element_data.at_css("p").text.strip
        news_element[:image] = absolute_link( url, element_data.at_css(".teaserImg img")['src'])
        news_element[:source] = absolute_link( url, element_data.at_css('a')['href'])
        news_element[:released_date] = Date.today
        result.push(news_element)
      end

    end

    def self.absolute_link(url, link)
      return url+ link
    end
  end
  def dw_scraping(data, url)
    result = []
    @url = url
    assets_url = url.split('/')[0..2].join("/")
    top_news_data = data.at_css('.imgTeaserL')
    featured_news_data = data.css(".imgTeaserS")
    other_news_data = data.css(".news")[0..10]
    # 先爬頭條
    DWNews::scrap_top_news(top_news_data, result, assets_url)
    # 再爬次要頭條
    DWNews::scrap_featured_news(featured_news_data, result, assets_url)
    # 再爬其他新聞
    DWNews::scrap_other_news(other_news_data, result, assets_url)
    # Mezhduna::scrap_other_news(other_news_data, @result,@url)
    return result
  end
end
