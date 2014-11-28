module Sabah
  class SabahNews
    
  end
  def sabah_scraping(data, url)
    result = []
    @url = url
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