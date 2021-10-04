class AddFieldToOrder < ActiveRecord::Migration[5.2]
  def change
      change_column_default :orders, :order_payment_type, 0
    # change_column :orders, :order_payment_type, default: 0
  end
end
