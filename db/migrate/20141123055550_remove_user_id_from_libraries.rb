class RemoveUserIdFromLibraries < ActiveRecord::Migration
  def change
    remove_column :libraries, :user_id, :integer
  end
end
