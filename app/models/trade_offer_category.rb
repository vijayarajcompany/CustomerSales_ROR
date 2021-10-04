class TradeOfferCategory < ApplicationRecord
  belongs_to :trade_offer
  belongs_to :category
end
