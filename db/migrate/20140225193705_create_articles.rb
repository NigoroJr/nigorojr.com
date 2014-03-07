class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      # Title of article
      t.string :title
      # Body of article
      t.string :body

      t.string :author
      t.string :category
      t.string :tags
      t.string :language

      t.timestamps
    end
  end
end
