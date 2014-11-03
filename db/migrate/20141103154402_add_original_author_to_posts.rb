class AddOriginalAuthorToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :original_author, :string
  end
end
