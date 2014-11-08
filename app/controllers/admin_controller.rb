class AdminController < ApplicationController
  

  before_action :authenticate_user!
  before_action :admin_require
  before_action :calculate_complete_count
  
  layout 'admin'

  protected

  def calculate_complete_count
    @ready_post_count = Post.ready.count
  end

  def admin_require
    unless current_user.admin?
      flash[:alert] = "You should not pass"
      redirect_to root_path 
    end
  end

end
