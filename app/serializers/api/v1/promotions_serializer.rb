class Api::V1::PromotionsSerializer < ActiveModel::Serializer
  attributes :id, :promo_no, :promodescription, :promoitems, :promo_customers, :discount_amount, :expirey_date
  has_many :promoitems
  has_many :promo_customers
end
