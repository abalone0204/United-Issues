class FindersController < ApplicationController
  before_action :get_finder, only: [:show]

  def index
    @finders = Finder.all
  end

  def show
    @found_posts = @finder.found_posts.page(params[:page]).per(10)
  end

  private
  def get_finder
    @finder = Admin::Finder.find(params[:id])
  end
end
