class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      # Title
      t.string :title
      # Path to the file that contains the body
      t.string :file_loc

      t.string :author
      t.string :category
      t.string :tags
      t.string :language

      t.timestamps
    end
  end
end
