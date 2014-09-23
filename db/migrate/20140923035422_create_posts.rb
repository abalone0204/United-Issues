class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :note
      t.string :source

      t.timestamps
    end
  end
end
