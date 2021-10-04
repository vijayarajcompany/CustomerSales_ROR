class AddOrderItemTypeToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :order_item_type, :integer, default: 0
    add_column :order_items, :trade_offer_id, :integer
  end
end
