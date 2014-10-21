class HomeController < ApplicationController
  layout 'home'
  def index
    @welcome = "United Issues"
    @featured_posts = Post.published.order("created_at").limit(5)
  end
end
