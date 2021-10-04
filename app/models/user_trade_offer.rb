class UserTradeOffer < ApplicationRecord
  belongs_to :user
  belongs_to :trade_offer
end
