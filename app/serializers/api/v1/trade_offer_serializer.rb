class Api::V1::TradeOfferSerializer < ActiveModel::Serializer
  attributes :id, :title, :tradeoffer_id, :tradeitem, :startdate , :enddate, :trade_offer_type, :status, :qualif_id, :qualif_desc, :sales_qty, :flex_grp, :flex_desc, :foc_qty, :offer_items
end
