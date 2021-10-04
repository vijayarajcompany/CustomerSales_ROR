class AddShoppingTypeToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :shopping_type, :integer, default: 0
  end
end
