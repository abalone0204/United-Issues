class AddOriginalAuthorToFoundPosts < ActiveRecord::Migration
  def change
    add_column :found_posts, :original_author, :string
  end
end
