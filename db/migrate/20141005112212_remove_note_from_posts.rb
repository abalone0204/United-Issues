class RemoveNoteFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :note, :string
  end
end
