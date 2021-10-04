class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.float :total_amount
      t.string :order_number
      t.integer :status, default: 0
      t.text :shipping_address
      t.references :promotion
      t.float :extra_charges
      t.float :order_item_amount
      t.text :shipping_address

      t.timestamps
    end
  end
end
