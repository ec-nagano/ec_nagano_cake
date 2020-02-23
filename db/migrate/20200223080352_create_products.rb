class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :category_id, index: true, foreign_key: true, null: false
      t.string :name
      t.text :content
      t.integer :price
      t.string :product_image_id
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
