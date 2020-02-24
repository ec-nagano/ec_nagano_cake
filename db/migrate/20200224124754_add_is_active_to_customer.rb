class AddIsActiveToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :is_active, :boolean, null: false, default: true
  end
end
