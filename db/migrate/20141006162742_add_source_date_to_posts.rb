class AddSourceDateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :source_date, :datetime
  end
end
