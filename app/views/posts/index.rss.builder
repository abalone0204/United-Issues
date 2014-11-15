xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "United Issue"
    xml.description "最新翻譯文章"
    xml.link posts_url

    for post in @posts_for_rss
      xml.item do
        xml.title render_post_title(post)
        xml.description briefly(post, 50)
        xml.pubDate post.publish_date.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end