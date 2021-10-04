class OrderItem < ApplicationRecord
  belongs_to :item_master
  # belongs_to :pack
  belongs_to :order, optional: true

  after_save :set_order_source_amount!, :apply_offer!#, :check_item_master_in_cart!

  before_destroy :set_order_source_amount_on_destroy!
  after_destroy :update_order
  enum status: [:processing, :placed, :pending, :shipped, :complete, :cancelled, :errored]

  def update_order
    if order.order_items.count == 0
      order.update(trade_offer_id: nil)
    end
  end

  enum order_item_type: [:purchased, :offered]
  enum shopping_type: [:shop, :trade_offer]

  def total_amount
    item_master_price&.round(2)
  end

  def item_master_price
    (item_master&.price || 0) * (quantity || 1)
  end

  def total_quantity
    quantity
  end

  def set_order_source_amount!
    puts 'sdfjkl123456'
    if order.order_items.any?
      order.update(source_amount: order.reload.order_items.purchased.sum(&:item_master_price))
    end
  end

  def set_order_source_amount_on_destroy!
    puts 'sdfjkl'
    order.update(source_amount: order.reload.order_items.where.not(id: self.id).sum(&:item_master_price))
  end

  # def check_item_master_in_cart!
  #   if order.item_masters.where(id: item_master.id).exists?
  #     message: item
  #   else
  #     update!
  #   end
  # end
  # def update_order_item
  #   @order_item = order.item_masters.find_by(id: item_master.id).order_items
  #   @order_item.update(quantity: @order_item.quantity + self.quantity)
  # end

  def apply_offer!
    return remove_trade_offer unless order.trade_offer?
    return remove_trade_offer unless trade_offers.any?
    return nil if offer_already_applied?
    trade_offer = trade_offers.first
    offered_item_master = ItemMaster.find_by(itemcode: trade_offer.itemcode)
    order.order_items.create(item_master: offered_item_master, quantity: trade_offer.foc_qty.to_i, order_item_type: 1, trade_offer_id: trade_offer.id, offer_by_id: id)
    update(trade_offer_id: trade_offer.id)
  end

  def remove_trade_offer
    order.order_items.offered.where(offer_by_id: id).destroy_all
  end

  def offer_already_applied?
    (trade_offers.ids & order.order_items.offered.pluck(:trade_offer_id)).present?
  end

  def trade_offers
    TradeOffer.where("CAST (sales_qty AS INTEGER) <= ? AND itemcode = ?", total_quantity, item_master.itemcode)
  end
end
