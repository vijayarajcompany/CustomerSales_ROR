class CreateSaleorders < ActiveRecord::Migration[5.2]
  def change
    create_table :saleorders do |t|
      t.string :customercode, limit: 10, null: false
      t.string :sales_org, limit: 4, null: false
      t.string :distr_chain, limit: 4, null: false
      t.string :division, limit: 4, null: false
      t.datetime :deliverydate, null: false
      t.string :source
      t.string :lpo
      t.string :createdby, limit: 10
      t.string :sender
      t.text   :products, array: true, default: []
      t.string :itemcode, limit: 18, null: false
      t.decimal :quantity, null: false
      t.string :offer_flag, limit: 1
      t.string :promoid, limit: 10
      t.string :offerid, limit: 10

      t.timestamps
    end

    add_index :saleorders, :customercode
  end
end
