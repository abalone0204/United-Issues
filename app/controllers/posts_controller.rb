class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new]
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
    @found_post_hash =params[:found_post]
    if @found_post_hash.present?
      import_hash_value(@post, @found_post_hash)
    end


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

  def import_hash_value(post, import_hash)
    post.found_post_id = import_hash[:found_post_id].to_i
    post.title = import_hash[:title]
    post.original_author =import_hash[:original_author]
    post.country_classification = import_hash[:country_classification]
    post.remote_image_url = import_hash[:remote_image_url]
    post.source_date = import_hash[:source_date]
    post.source =import_hash[:source]
  end

  def validate_publish
    if !@post.publish? && @post.user_id != current_user.id
      flash[:error] = "此文章尚未發佈"
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit( :found_post_id, :source_date, :remote_image_url, :image, :user_id,:title, :content, :note, :source,
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
