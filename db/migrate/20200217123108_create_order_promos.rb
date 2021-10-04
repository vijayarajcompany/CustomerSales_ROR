class CreateOrderPromos < ActiveRecord::Migration[5.2]
  def change
    create_table :order_promos do |t|
      t.references :order
      t.references :promotion
      t.timestamps
    end
  end
end
