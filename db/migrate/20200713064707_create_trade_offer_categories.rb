class CreateTradeOfferCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :trade_offer_categories do |t|
      t.references :trade_offer
      t.references :category
      t.timestamps
    end
    add_column :orders, :shopping_type, :integer, default: 0
    add_column :orders, :trade_offer_id, :integer
  end
end
