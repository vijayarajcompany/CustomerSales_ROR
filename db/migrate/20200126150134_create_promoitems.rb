class CreatePromoitems < ActiveRecord::Migration[5.2]
  def change
    create_table :promoitems do |t|
      t.references :customer_master
      t.references :promotion
      t.string :sales_item
      t.string :sale_qty
      t.string :sale_uom
      t.string :foc_item
      t.string :foc_qty
      t.string :add_2
      t.string :add_3
      t.timestamps
    end
  end
end
