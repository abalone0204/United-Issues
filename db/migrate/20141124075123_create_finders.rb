class CreateFinders < ActiveRecord::Migration
  def change
    create_table :finders do |t|
      t.boolean :available
      t.string :site_name
      t.string :country_classification

      t.timestamps
    end
  end
end
