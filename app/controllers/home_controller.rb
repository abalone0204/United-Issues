class HomeController < ApplicationController
  layout 'home'
  
  def index
    get_posts(Post.published.count)
  end

  private
  
  def get_posts(number)
    posts = Post.published.order("publish_date DESC").limit(number).map{|post| post}
    @topic_posts = posts[0..1]
    @featured_posts = posts[2..number]
    @featured_posts = Kaminari.paginate_array(@featured_posts).page(params[:page]).per(20)
  end
end
