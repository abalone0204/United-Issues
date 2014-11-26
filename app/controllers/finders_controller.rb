class FindersController < ApplicationController
  before_action :get_finder, only: [:show]
  authorize_resource :finder
  def index
    @finders = Finder.all
  end

  def show
    @found_posts = @finder.found_posts.page(params[:page]).per(10)
  end
  
  def find_daily_news
    @finder.get_daily_news
    flash[:notice] = "已成功更新Finder news"
    redirect_to admin_finders_path
  end

  private
  def get_finder
    @finder = Admin::Finder.find(params[:id])
  end
end
