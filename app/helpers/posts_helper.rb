module PostsHelper

  def briefly(post, length = 14)
    str = post.content.gsub(/#/, "").gsub(/_/, "").gsub(/-/, "")
    truncate(str, length: length)
  end


  def render_post_image(post, size=:display)
     if post.image.present? 
        post.image_url(size)
     else   
       "http://united-issue.com/assets/default-thumb-b99a5372e15d1b287dc4a535df1d1c2d.png"
     end 
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

  def complete_label(post)
    if post.complete == "not_yet"
      "label-default"
    else
      "label-success"
    end
  end
end
