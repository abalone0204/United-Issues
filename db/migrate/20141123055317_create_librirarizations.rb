class CreateLibrirarizations < ActiveRecord::Migration
  def change
    create_table :librirarizations do |t|
      t.integer :user_id
      t.integer :library_id

      t.timestamps
    end
  end
end
