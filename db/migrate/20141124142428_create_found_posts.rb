class CreateFoundPosts < ActiveRecord::Migration
  def change
    create_table :found_posts do |t|
      t.string :title
      t.string :description
      t.date :released_date
      t.string :source
      t.integer :finder_id
      t.string :image

      t.timestamps
    end
  end
end
