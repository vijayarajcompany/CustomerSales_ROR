class CreateCustomerPriceLists < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_price_lists do |t|
      t.string :customercode, null: false
      t.string :itemcode, null: false
      t.string :startdate
      t.string :enddate
      t.string :each_sales_price
      t.string :carton_sales_price
      t.string :delimit

      t.timestamps
    end

    add_index :customer_price_lists, :customercode
    add_index :customer_price_lists, :itemcode
  end
end
