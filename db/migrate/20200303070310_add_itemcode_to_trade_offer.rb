class AddItemcodeToTradeOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :trade_offers, :itemcode, :string
  end
end
