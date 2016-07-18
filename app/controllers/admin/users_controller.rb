class Admin::UsersController < AdminController
  authorize_resource :user
  def index
    @admin_users = Admin::User.includes(:posts).order('posts_count DESC')
  end

  def show
    @admin_user = User.includes(:posts).find(params[:id])
  end

  def toggle_admin
    params[:user_ids] = params[:user_ids].map{|i| i.to_i}
    @admin_users = Admin::User.find(params[:user_ids])
    @admin_users.each do |user|
      user.toggle_admin!
      user.save
    end
    redirect_to admin_users_path 
  end

  def toggle_editor
    params[:user_ids] = params[:user_ids].map{|i| i.to_i}
    @admin_users = Admin::User.find(params[:user_ids])
    @admin_users.each do |user|
      user.toggle_editor!
      user.save
    end
    redirect_to admin_users_path 
  end

end
