class AddSiteUrlToFinders < ActiveRecord::Migration
  def change
    add_column :finders, :site_url, :string
  end
end
