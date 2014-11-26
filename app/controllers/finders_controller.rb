class FindersController < ApplicationController
  before_action :get_finder, only: [:show, :find_daily_news]
  authorize_resource :finder
  

  def index
    @finders = Finder.all
  end

  def show
    @found_posts = @finder.found_posts.page(params[:page]).per(10)
  end
  
  def find_daily_news
    @finder.get_daily_news(current_user)
    flash[:notice] = "已成功更新Finder news, 恭喜你獲得乖寶寶點數一點"
    redirect_to finder_path(@finder)
  end

  private
  def get_finder
    @finder = Finder.find(params[:id])
  end
end
