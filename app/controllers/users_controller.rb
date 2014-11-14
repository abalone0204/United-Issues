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
    
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
