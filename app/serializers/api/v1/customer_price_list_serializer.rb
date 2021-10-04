class Api::V1::CustomerPriceListSerializer < ActiveModel::Serializer
  attributes :customercode, :itemcode, :startdate, :enddate, :each_sales_price, :carton_sales_price, :delimit
end