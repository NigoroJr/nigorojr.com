class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string  :title
      t.text    :body

      t.string  :author_username
      t.string  :category
      t.string  :tags
      t.string  :language

      t.timestamps
    end
  end
end