class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new]
  authorize_resource :post
  before_action :validate_publish, only: [:show]

  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).published.order("created_at DESC").page(params[:page])
    else
      @posts = Post.published.order("created_at DESC").page(params[:page])
    end
    if params[:classification].present?
      @posts = @posts.country(params[:classification]).order("created_at DESC").page(params[:page])
    end
  end

  def show

  end

  def new
    @post = Post.new

  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      flash[:error] = "您輸入的資料有誤"
      render :new
    end
  end

  def edit

  end

  def update

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def my_posts
    @posts = Post.where(user_id: current_user.id).order("created_at DESC").page(params[:page])
  end

  private

  def validate_publish
    if !@post.publish? && @post.user_id != current_user.id
      flash[:error] = "此文章尚未發佈"
      redirect_to posts_path 
    end
  end

  def post_params
    params.require(:post).permit( :user_id,:title, :content, :note, :source,
                                  :country_classification, :tag_list)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
