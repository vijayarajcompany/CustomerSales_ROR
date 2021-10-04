class AddOrderPaymentTypeToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_payment_type, :integer
  end
end
