xml.instruct! :xml, :version => "1.0" 
xml.rss version: "2.0", "xmlns:media" => "http://search.yahoo.com/mrss/", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "United Issue"
    xml.description "最新翻譯文章"
    xml.link posts_url
    xml.hr
    for post in @posts_for_rss
      xml.item do
        xml.title render_post_title(post)
        xml.description image_tag(image_url(render_post_image(post, :thumb)))+simple_format(post.content)
        xml.pubDate post.publish_date.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
        xml.hr
      end
    end
  end
end