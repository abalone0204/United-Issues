class AdminController < ApplicationController
  

  before_action :authenticate_user!
  before_action :admin_require
  layout 'admin'

  protected

  def admin_require
    unless current_user.admin?
      flash[:alert] = "You should not pass"
      redirect_to root_path 
    end
  end

end
