class CreateOrderedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :ordered_items do |t|
      t.integer :order_id, index: true, foreign_key: true, null: false
      t.integer :product_id, index: true, foreign_key: true, null: false
      t.integer :price
      t.integer :amount
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
