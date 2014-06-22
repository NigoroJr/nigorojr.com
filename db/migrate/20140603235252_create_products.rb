class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name
      t.string  :description
      t.string  :website
      t.string  :category
      t.string  :team
      t.date    :updated
      t.string  :version

      t.timestamps
    end
  end
end
