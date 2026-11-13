# Mensa's table views and exports belong to users
class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.timestamps
    end
  end
end
