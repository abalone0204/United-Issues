class Admin::PostsController < AdminController
  http_basic_authenticate_with name: ENV["admin"], password: ENV["adpwd"]
  before_action :get_admin_post, only: [:show, :edit, :update, :destroy]

  def notification
    @admin_posts = Admin::Post.includes(:user).order("publish_date DESC").ready.page(params[:page])
  end

  def schedule
    @admin_posts = Admin::Post.includes(:user).order("publish ASC").page(params[:page])
    @admin_posts = display_options(@admin_posts, params[:display_options])
  end

  def set_publish_time
    if params[:post_ids].present?
      params[:post_ids] = params[:post_ids].map{|i| i.to_i}
      @admin_posts = Admin::Post.find(params[:post_ids])
      @admin_posts.each do |post|
        post.publish = true
        post.update_attribute(:publish_date, params[:set_publish_time])
        post.save
      end
    end
    redirect_to schedule_admin_posts_path
  end

  def toggle_publish
    if params[:post_ids].present?
      params[:post_ids] = params[:post_ids].map{|i| i.to_i}
      @admin_posts = Admin::Post.find(params[:post_ids])
      @admin_posts.each do |post|
        post.toggle_publish!
        post.save
      end
    end
    redirect_to admin_posts_path
  end
  #GET /admin/posts
  # GET /admin/posts.json
  def index
    @admin_posts = Admin::Post.includes(:user).order("created_at DESC").page(params[:page])
    @admin_posts = display_options(@admin_posts, params[:display_options])
  end

  # GET /admin/posts/1
  # GET /admin/posts/1.json
  def show
  end

  # GET /admin/posts/new
  def new
    @admin_post = Admin::Post.new
  end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts
  # POST /admin/posts.json
  def create
    @admin_post = Admin::Post.new(admin_post_params)
    @admin_post.user_id = current_user.id
    respond_to do |format|
      if @admin_post.save
        format.html { redirect_to @admin_post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @admin_post }
      else
        format.html { render :new }
        format.json { render json: @admin_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/posts/1
  # PATCH/PUT /admin/posts/1.json
  def update
    respond_to do |format|
      if @admin_post.update(admin_post_params)
        format.html { redirect_to @admin_post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_post }
      else
        format.html { render :edit }
        format.json { render json: @admin_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/posts/1
  # DELETE /admin/posts/1.json
  def destroy
    @admin_post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def get_admin_post
    @admin_post = Admin::Post.find(params[:id])
  end

  def display_options(posts, options)
    if options.present?
      posts = posts.send(options)
    else
      posts
    end
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_post_params
    params.require(:admin_post).permit( :publish, :publish_date, :user_id,:title, :content, :note, :source,
                                        :country_classification, :tag_list, :complete)
  end


end
