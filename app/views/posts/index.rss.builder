xml.instruct! :xml, :version => "1.0" 
xml.rss version: "2.0", "xmlns:media" => "http://search.yahoo.com/mrss/", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "United Issue"
    xml.description "最新翻譯文章"
    xml.link posts_url
    xml.hrg
    for post in @posts_for_rss
      xml.item do
        xml.title simple_date(post.publish_date)+" "+render_post_title(post)
        xml.description image_tag(image_url(render_post_image(post, :thumb)))+"<br>".html_safe+"<br>".html_safe+briefly(post, 50)+"<br>".html_safe+link_to("繼續閱讀",post).html_safe
        xml.pubDate simple_date(post.publish_date)
        xml.link post_url(post)
        xml.guid post_url(post)
        xml.hr
      end
    end
  end
end


