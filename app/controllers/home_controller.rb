class HomeController < ApplicationController
  layout 'home'
  
  def index
    get_posts(8)
  end

  private
  
  def get_posts(number)
    posts = Post.published.order("created_at DESC").limit(number).map{|post| post}
    @topic_posts = posts[0..1]
    @featured_posts= posts[2..number]
  end
end
