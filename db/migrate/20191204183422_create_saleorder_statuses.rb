class CreateSaleorderStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :saleorder_statuses do |t|
      t.string :sale_orderid, null: false
      t.string :target
      t.string :order_status

      t.timestamps
    end

    add_index :saleorder_statuses, :sale_orderid
  end
end
