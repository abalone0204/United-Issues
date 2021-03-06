class UsersController < ApplicationController
  before_action :find_user
  

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
