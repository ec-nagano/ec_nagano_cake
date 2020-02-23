class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id, index: true, foreign_key: true, null: false
      t.string :recipient
      t.string :address
      t.string :postcode
      t.integer :delivery_fee, null: false, default: 800
      t.integer :billing_amount
      t.integer :payment
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
