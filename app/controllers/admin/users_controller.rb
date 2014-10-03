class Admin::UsersController < AdminController
  def index
    @users = Admin::User.all
  end
end
