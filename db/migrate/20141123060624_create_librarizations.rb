class CreateLibrarizations < ActiveRecord::Migration
  def change
    create_table :librarizations do |t|
      t.integer :user_id
      t.integer :library_id

      t.timestamps
    end
  end
end
