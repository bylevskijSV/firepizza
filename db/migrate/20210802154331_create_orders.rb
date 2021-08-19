class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :street
      t.integer :house_number
      t.integer :subway_number
      t.integer :apartment_number
      t.string  :note
      t.float   :total_for_pizzas
      t.float   :shipping
      t.boolean :confirmed_by, default: false
      t.boolean :close, default: false

      t.timestamps
    end
  end
end
