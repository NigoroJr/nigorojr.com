class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :title
      t.string :body

      t.string :author
      t.string :category
      t.string :tags
      t.string :language

      t.timestamps
    end
  end
end
