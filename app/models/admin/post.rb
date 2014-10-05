class Admin::Post < Post

  def toggle_publish!
    self.publish = !self.publish
    self.publish_date ||= Date.today
  end

end
