class AddContryClassificationToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :country_classification, :string
  end
end
