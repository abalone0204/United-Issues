class AddCompleteToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :complete, :boolean, default: false
  end
end
