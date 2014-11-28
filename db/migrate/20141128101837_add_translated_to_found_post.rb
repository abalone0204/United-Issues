class AddTranslatedToFoundPost < ActiveRecord::Migration
  def change
    add_column :found_posts, :translated, :boolean, default: false
  end
end
