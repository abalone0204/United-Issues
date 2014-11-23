class AddOriginalNameToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :original_name, :string
  end
end
