class OrderItemPackId < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :pack_id, :float
  end
end
