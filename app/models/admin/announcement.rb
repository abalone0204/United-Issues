class Admin::Announcement < Announcement
  before_create :set_user_id
  
  private

  def set_user_id
      self.user_id = User.current.id
  end  
end
