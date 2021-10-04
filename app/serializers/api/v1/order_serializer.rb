class Api::V1::OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_amount, :order_number, :status, :shipping_address, :promotion_id, :extra_charges, :order_item_amount, :promotion_amount, :total_amount, :source_amount, :order_items, :order_payment_type, :created_at, :updated_at, :cart_item_count, :order_date, :shipping_charge#, :vat_charge

  belongs_to :promotion
  belongs_to :user
  has_one :address

  def order_items
    ActiveModel::Serializer::CollectionSerializer.new(object.order_items.order('created_at DESC'), serializer: Api::V1::OrderItemSerializer).as_json
  end
end
