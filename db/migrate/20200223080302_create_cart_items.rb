class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :customer_id, index: true, foreign_key: true, null: false
      t.integer :product_id, index: true, foreign_key: true, null: false
      t.integer :amount

      t.timestamps
    end
  end
end
