class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :customers, id: :uuid do |t|
      t.string :name
      t.string :email
      t.timestamps
    end

    create_table :products, id: :uuid do |t|
      t.string :name
      t.timestamps
    end

    create_table :orders, id: :uuid do |t|
      t.references :customer, type: :uuid
      t.string :number
      t.decimal :total
      t.datetime :placed_at
      t.timestamps
    end

    create_table :order_lines, id: :uuid do |t|
      t.references :order, type: :uuid
      t.references :product, type: :uuid
      t.integer :quantity
      t.timestamps
    end
  end
end
