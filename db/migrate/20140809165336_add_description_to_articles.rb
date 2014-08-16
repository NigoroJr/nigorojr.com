class AddDescriptionToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :description, :text
  end
end
