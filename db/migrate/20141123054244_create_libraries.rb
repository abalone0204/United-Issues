class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :oringinal_name
      t.string :translated_name
      t.string :country_classification
      t.integer :user_id
      t.timestamps
    end
  end
end
