class AdminController < ApplicationController
  
  http_basic_authenticate_with name: ENV["admin"], password: ENV["adpwd"]
  before_action :authenticate_user!
  before_action :admin_require
  before_action :calculate_complete_count
  before_action :current_ability
  layout 'admin'

  protected

  def calculate_complete_count
    @ready_post_count = Post.ready.count
  end

  def admin_require
    unless current_user.admin? || current_user.editor?
      flash[:alert] = "You should not pass"
      redirect_to root_path 
    end
  end
  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end
end
