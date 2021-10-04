class CreateTradeOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :trade_offers do |t|
      t.string :tradeoffer_id, null: false
      t.string :tradeitem, null: false
      t.string :startdate
      t.string :enddate
      t.string :trade_offer_type
      t.string :status
      t.string :qualif_id
      t.string :qualif_desc
      t.string :sales_qty
      t.string :flex_grp
      t.string :flex_desc
      t.string :foc_qty
      t.text :offer_items, array: true, default: []

      t.timestamps
    end

    add_index :trade_offers, :tradeoffer_id
    add_index :trade_offers, :tradeitem
  end
end
