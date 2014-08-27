class CreateSkkdictEntries < ActiveRecord::Migration
  def change
    create_table :skkdict_entries do |t|
      t.string :reading, null: false
      t.string :word, null: false
      t.string :tags
      t.string :posted_by

      t.timestamps
    end
  end
end
