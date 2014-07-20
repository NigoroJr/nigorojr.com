class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :screen
      t.string :username, null: false
      t.string :hashed_password, null: false

      t.timestamps
    end
  end
end
