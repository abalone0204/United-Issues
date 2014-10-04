class Admin::Post < Post
  def toggle_publish!
    self.publish = !self.publish
  end
end
