class Order < ApplicationRecord
  belongs_to :user
  belongs_to :promotion, optional: true
  has_many :order_items, dependent: :destroy
  has_many :item_masters, through: :order_items
  has_one :address, as: :addressable
  has_paper_trail skip: [:user_id, :total_amount, :order_number, :shipping_address, :promotion_id, :extra_charges, :order_item_amount, :created_at, :updated_at, :source_amount, :promotion_amount]
  belongs_to :trade_offer, optional: true

  enum status: [:processing, :placed, :pending, :shipped, :complete, :cancelled, :errored, :ice_creams_delivered, :beverages_snacks_delivered]
  enum order_payment_type: ['Cash Or Card Payment On Delivery']
  enum shopping_type: [:shop, :trade_offer]

  accepts_nested_attributes_for :order_items, :allow_destroy => true
  accepts_nested_attributes_for :address, :allow_destroy => true
  before_save :set_order_total_amount!
  after_create :set_order_number!

  before_save :remove_order_items
  before_save :remove_order_items_not_related_to_trade, if: :trade_offer_id_changed?

  delegate :longitude, :latitude, :title, :mobile_number, :address_type, :category, :alternative_number, :alternative_number_country_code, :mobile_number_country_code, to: :address, allow_nil: true

  def remove_order_items
    if trade_offer?
      order_items.shop.delete_all
    else
      order_items.trade_offer.delete_all
    end
    # self.source_amount = order_items.sum(&:item_master_price)
  end

  def remove_order_items_not_related_to_trade
    order_items.trade_offer.where.not(trade_offer_id: trade_offer_id).delete_all
    self.source_amount = order_items.sum(&:item_master_price)
  end

  def cart_item_count
    order_items.count
  end

  def apply_promo!(promotion)
    if promotion.present? && promotion.can_use_coupon?(user)
      OrderPromo.create!(order_id: self.id, promotion_id: promotion.id)
      self.promotion_amount = promotion.discount_amount || 0
      self.total_amount = (self.source_amount - (promotion.discount_amount || 0))
      save
    else
      false
    end
  end

  def remove_promo!
    order_promo = OrderPromo.find_by(order_id: self.id)
    order_promo.destroy
    self.promotion_amount = 0
    self.total_amount = self.source_amount
    save
  end

  def set_order_number!
    update_columns(order_number: "PEPSI-#{id}-#{created_at.to_i}")
  end

  def cashed?
    true
  end

  def credited?
    true
  end

  def place_order!
    PlaceOrder.new(self).execute!
  end

  def set_order_total_amount!
    unless promotion.present?
      self.total_amount = self.source_amount || 0
    end
  end

  def current_address
    address || create_address
  end

  def created_by_sap
    "#{address&.title}|#{address&.address}|#{address&.latitude}|#{address&.longitude}|#{address&.mobile_number}|#{address&.alternative_number}"
  end

  def order_date
    place_order_date&.strftime('%Y/%m/%d')
  end

  def delivery_date
    ((place_order_date || DateTime.now) + 2.day).strftime('%Y%m%d')
  end

  def vat_charge
    self[:vat_charge]&.round(2)
  end

  def total_amount
    self[:total_amount]&.round(2)
  end
end
