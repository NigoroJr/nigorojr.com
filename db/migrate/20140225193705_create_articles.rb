class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      # Title of article
      t.string :title
      # Path to the file that contains the body of article
      t.string :file_loc

      t.string :author
      t.string :category
      t.string :tags
      t.string :language

      t.timestamps
    end
  end
end
