module PostsHelper

  def briefly(post, length = 14)
    str = post.content.gsub(/#/, "").gsub(/_/, "").gsub(/-/, "")
    truncate(str, length: length)
  end


  def render_post_image(post, size=:display)
    if post.image.present?
      post.image_url(size)
    else
      'default-thumb.png'
    end
  end

  def lazy_render_post_image(post, size=:display)
    if post.image.present?
      post.image_url(size)
    else
      image_path('default-thumb.png')
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
  def render_post_data(data_arr, condition_1, condition_2)
      data_arr.each do|data|
      @classification_titles.each do |first|
        if ord[0] == first
          @country_titles.each do |second|
            if ord[1] == second
              ord[2]
            else
              ''
            end
          end
        else
          ''
        end
      end
    end
    
  end
end
