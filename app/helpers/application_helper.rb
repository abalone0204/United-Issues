module ApplicationHelper
  def tag_cloud(tags, classes)
    i = 0
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  def tags_cloud(tags, classes)
    
  end

  def simple_format(text)
    options = {hard_wrap: true, filter_html: true, autolink: true, no_intraemphasis: true}
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end

  def format_time(time)
    if time.present?
      time.strftime("%Y-%m-%d")
    end
  end

end
