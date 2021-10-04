class Api::V1::SaleorderStatusSerializer < ActiveModel::Serializer
  attributes :sale_orderid, :target, :order_status
end