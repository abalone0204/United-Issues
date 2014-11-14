class RemoveFbIdFromUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      if user.provider != 'facebook'
        user.update_attribute(:provider, 'facebook')  
      end
      if user.fb_id.present?
        user.update_attribute(:uid, user.fb_id)
      end
    end
    remove_column :users, :fb_id, :integer
  end
end
