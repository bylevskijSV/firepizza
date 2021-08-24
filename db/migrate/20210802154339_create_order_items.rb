class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :product, null: false, foreign: true
      t.belongs_to :order, null: false, foreign: true
      t.float   :unit_price
      t.integer :quantity
      t.float   :total

      t.timestamps
    end
  end
end
