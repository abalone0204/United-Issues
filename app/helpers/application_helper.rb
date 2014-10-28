module ApplicationHelper

  def search_options(option, params)
    options = {}
    keys =[:classification, :country_classification]
    
    keys.each do |key|
      if params[key]
        options[key] = params[key]    
      end
    end

    option.each do |key, value|
      options[key] = value
    end

    options
  end

  def simple_date_time(date)
    if date
      date.strftime('%Y-%m-%d %I:%M %p')
    end
  end

  def simple_format(text)
    options = {hard_wrap: true, filter_html: true, autolink: true, no_intraemphasis: true}
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end

  def simple_date(time)
    if time.present?
      time.strftime("%Y-%m-%d")
    end
  end




end
