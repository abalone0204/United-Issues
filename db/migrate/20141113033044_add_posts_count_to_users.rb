class AddPostsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :posts_count, :integer, default: 0
    User.reset_column_information
    User.all.each do |user|
      user.update_attribute(:posts_count, user.posts.length)
    end
  end
end
