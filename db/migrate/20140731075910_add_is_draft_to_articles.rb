class AddIsDraftToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :is_draft, :boolean, default: false
  end
end
