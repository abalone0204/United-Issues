class Admin::PostsController < AdminController
  before_action :get_admin_post, only: [:edit, :update, :destroy]
  authorize_resource :post
  def notification
    @posts = Admin::Post.includes(:user).order("publish_date DESC").ready.page(params[:page])
  end

  def schedule
    get_sorted_posts
    @posts = Kaminari.paginate_array(@admin_posts).page(params[:page]).per(8)
    # @admin_posts = display_options(@admin_posts, params[:display_options])
  end

  def set_publish_time
    if params[:post_ids].present?
      params[:post_ids] = params[:post_ids].map{|i| i.to_i}
      @posts = Admin::Post.find(params[:post_ids])
      @posts.each do |post|
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
    @posts = Admin::Post.includes(:user).order("created_at DESC").page(params[:page])
    @posts = display_options(@posts, params[:display_options])
  end

  # GET /admin/posts/1
  # GET /admin/posts/1.json
  def show
    @admin_post = Post.find(params[:id])
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

  def statistics
    @admin_post = Post.published
    get_statistics_data(@admin_post)
    respond_to do |format|
      format.html
      format.json
    end
  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def get_admin_post
    @admin_post = Admin::Post.find(params[:id])
  end

  def get_sorted_posts
    confirm_unscheduled_posts = Admin::Post.includes(:user).where('publish = ? AND publish_date is null', true)
    scheduled_posts = Admin::Post.includes(:user).where('publish = ? AND publish_date is not null', true).order('publish_date DESC')
    unconfirm_posts = Admin::Post.includes(:user).where('publish = ?', false)
    @admin_posts = confirm_unscheduled_posts+scheduled_posts+unconfirm_posts
  end

  def display_options(posts, options)
    if options.present?
      posts = posts.send(options)
    else
      posts
    end
  end

  def get_statistics_data(posts)
    @classifications_total = posts.group_by(&:classification).map{|p| [p[0].text, p[1].count]}
    @country_classifications_total = posts.group_by(&:country_classification).map{|p| [p[0].text, p[1].count]}
    @data_arr = posts.group_by{ |s| [s.classification, s.country_classification] }.map {|k,v| [k.first.text, k.last.text, v.length]}
    @classification_titles = Post.classification.options.map{|p| p[0]}
    @classification_titles_key = Post.classification.options.map{|p| p}
    @country_titles = Post.country_classification.options.map{|p| p[0]}
    @country_titles_key = Post.country_classification.options.map{|p| p}

  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_post_params
    params.require(:admin_post).permit( :publish, :publish_date, :user_id,:title, :content, :note, :source,
                                        :country_classification, :tag_list, :complete)
  end


end
