class AddTradeOfferToSubcategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :subcategories, :trade_offer, foreign_key: true
  end
end
