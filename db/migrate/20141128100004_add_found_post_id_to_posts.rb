class AddFoundPostIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :found_post_id, :integer
  end
end
