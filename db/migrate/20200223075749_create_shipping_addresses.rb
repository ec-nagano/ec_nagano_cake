class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.integer :customer_id, index: true, foreign_key: true, null: false
      t.string :name
      t.string :postcode
      t.string :address

      t.timestamps
    end
  end
end
