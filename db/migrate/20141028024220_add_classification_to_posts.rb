class AddClassificationToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :classification, :string
  end
end
