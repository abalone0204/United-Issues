class RemoveFbIdFromUsers < ActiveRecord::Migration
  def change
    if User.any?
      User.all.each do|user|
        user.update_attribute(:provider, 'facebook')
        if user.fb_id.present?
          user.update_attribute(:uid, user.fb_id)
        end
      end
    end
    remove_column :users, :fb_id, :string
  end
end
