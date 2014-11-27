class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :profile
      t.string :politics

      t.timestamps
    end
  end
end
