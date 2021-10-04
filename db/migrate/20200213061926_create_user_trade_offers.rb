class CreateUserTradeOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_trade_offers do |t|
      t.references :trade_offer
      t.references :user
      t.timestamps
    end
  end
end
