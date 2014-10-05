class AddNoteToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :note, :text, default: ""
  end
end
