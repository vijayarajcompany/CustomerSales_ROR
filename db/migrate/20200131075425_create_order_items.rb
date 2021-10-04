class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :item_master, foreign_key: true
      t.integer :quantity
      t.integer :pack_size
      t.float :amount
      t.timestamps
    end
  end
end
