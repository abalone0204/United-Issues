class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new]
  authorize_resource :post
  before_action :validate_publish, only: [:show]

  def index
    happy_bug
    @posts = Post.published.search(params)
    @posts_for_rss = @posts.order("publish_date DESC").limit(5)
    @posts = @posts.order("publish_date DESC").page(params[:page]).per(20)

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
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
    @published_posts = Post.published
    get_statistics_data(@published_posts)
    respond_to do |format|
      format.html
      format.json
    end

  end

  private

  def get_statistics_data(posts)
    @data_arr = posts.group_by{ |s| [s.classification, s.country_classification] }.map {|k,v| [k.first.text, k.last.text, v.length]}
    @classification_titles_key = Post.classification.options.map{|p| p}
    @country_titles_key = Post.country_classification.options.map{|p| p}
  end

  def validate_publish
    if !@post.publish? && @post.user_id != current_user.id
      flash[:error] = "此文章尚未發佈"
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit( :source_date, :remote_image_url, :image, :user_id,:title, :content, :note, :source,
                                  :country_classification, :classification, :tag_list,
                                  :original_author, :complete)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def happy_bug
    trigger = params[:search].to_s
    if trigger.downcase.start_with?("say")
      word = trigger.delete("say").gsub(/\s+/, "")
      redirect_to say_path(word)
    elsif trigger.downcase == "how do you turn this on"
      redirect_to car_path(1)
    elsif trigger == "stallions"
      redirect_to stallions_path
    end
  end

end
