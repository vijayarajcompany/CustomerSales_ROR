class Offer < ApplicationRecord
  has_many :product_offers

  TYPES = %w(
    Direct TradeOffer Promotional
  ).freeze

  enum rate_type: %i[fixed percentage]
end
