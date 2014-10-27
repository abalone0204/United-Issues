module PostsHelper

  def briefly(post, length = 14)
    str = post.content.gsub(/#/, "")
    truncate(str, length: length)
  end


  def render_post_image(post, size=:display)
     if post.image.present? 
        post.image_url(size)
     else   
       "default-thumb.png"
     end 
  end

  def render_post_tags(post)
    post.tags.map(&:name).map { |t| link_to t, tag_path(t) }.join(', ')
  end

  def render_post_title(post)
    if post.country_classification.present?
      "【#{post.country_classification.text}】 #{post.title}"
    else
      "【尚未分類】 #{post.title}"
    end
  end

  def publish_status(post)
    if post.publish?
      "通過"
    else
      "未通過"
    end
  end
end
