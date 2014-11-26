class AddGgPointToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gg_point, :integer, default: 0
  end
end
