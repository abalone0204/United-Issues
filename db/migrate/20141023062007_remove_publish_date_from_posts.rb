class RemovePublishDateFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :publish_date
  end
end
