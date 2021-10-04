class AddNameToTradeOffer < ActiveRecord::Migration[5.2]
  def up
    change_column :trade_offers, :tradeoffer_id, :string, null: true
    add_column :trade_offers, :title, :string
  end

  def down
    change_column :trade_offers, :tradeoffer_id, :string, null: false
    remove_column :trade_offers, :title, :string
  end
end
