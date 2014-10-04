module Admin::UsersHelper
  def render_user_role(user)
    if user.admin?
      "Admin"
    else
      "User"
    end
  end
end
