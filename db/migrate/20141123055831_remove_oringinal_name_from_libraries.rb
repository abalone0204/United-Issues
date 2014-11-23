class RemoveOringinalNameFromLibraries < ActiveRecord::Migration
  def change
    remove_column :libraries, :oringinal_name, :string
  end
end
