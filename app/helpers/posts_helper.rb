module PostsHelper
  
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
      "已發佈"
    else
      "尚未發佈"
    end
  end
end
