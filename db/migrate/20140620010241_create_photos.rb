class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string  :location
      t.string  :object
      t.string  :category
      t.string  :file_path

      t.timestamps
    end
  end
end
