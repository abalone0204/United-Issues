class Admin::User < User
  def toggle_admin!
    self.admin = !self.admin
  end
  def toggle_editor!
    self.editor = !self.editor
  end
end
