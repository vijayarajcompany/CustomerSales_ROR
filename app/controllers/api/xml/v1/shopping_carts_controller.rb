class Api::Xml::V1::ShoppingCartsController < ActionController::API
  include ApplicationXmlMethods
  soap_service namespace: 'urn:WashOut'

  # soap_action "index",
  #   :return => :xml
  # def index
  #   @orders = @current_user.orders.order('created_at DESC')
  #   render_success_response({
  #     orders: array_serializer.new(@orders, serializer: Api::V1::OrderSerializer).as_json
  #   })
  # end

  # soap_action "show_current",
  #   :return => :xml
  # def show_current
  #   @order = @current_user.current_order
  #   render_success_response({
  #     order: single_serializer.new(@order, serializer: Api::V1::OrderSerializer).as_json
  #   })
  # end

  # soap_action "show",
  #   :args   => {:id=> :integer},
  #   :return => :xml
  # def show
  #   @order = Order.find(params[:id])
  #   render_success_response({
  #     order: single_serializer.new(@order, serializer: Api::V1::OrderSerializer).as_json
  #   })
  # end

  # soap_action "add_address",
  #   :args   => {:order=>{:order_payment_type => :string, order_items_attributes: [
  #   ], addresses_attributes: [{title: :string, address: :string, active: :integer, _destroy: :integer}]}},
  #   :return => :xml
  # def add_address
  #   @order = @current_user.current_order
  #   if @order.update(order_params)
  #     render_success_response({
  #       order: single_serializer.new(@order , serializer: Api::V1::OrderSerializer).as_json
  #     }, I18n.t('updated', resource: 'order '))
  #   else
  #     render_unprocessable_entity_response(@order)
  #   end
  # end

  # soap_action "add_order_items",
  #   :args => {:order => {:order_payment_type => :string, order_items_attributes: [ {id: :integer, item_master_id: :integer, quantity: :integer, pack_size: :integer, pack_id: :integer, amount: :string, _destroy: :integer}], addresses_attributes: [{title: :string, address: :string, active: :integer, _destroy: :integer}]}},
  #   :return => :xml
  # def add_order_items
  #   @order = @current_user.current_order
  #   if @order.update(order_params)
  #     render_success_response({
  #       order: single_serializer.new(@order , serializer: Api::V1::OrderSerializer).as_json
  #     }, I18n.t('updated', resource: 'order '))
  #   else
  #     render_unprocessable_entity_response(@order)
  #   end
  # end

  # soap_action "place_order",
  #   :args => {:order=>{:order_payment_type => :string, order_items_attributes: [], addresses_attributes: []}},
  #   :return => :xml
  # def place_order
  #   @order = @current_user.current_order
  #   @order.update(order_params)
  #   place_order = @order.place_order!
  #   if place_order.valid?
  #     render_success_response({
  #       order: single_serializer.new(@order , serializer: Api::V1::OrderSerializer).as_json
  #     }, 'Order has been placed')
  #   else
  #     render_unprocessable_entity([{error: "Due to connection issue, order not place, try after sometime.", detail: "Due to connection issue, order not place, try after sometime."}])
  #   end
  # end


  # soap_action "cancele_order",
  #   :args   => {:order_id => :integer},
  #   :return => :xml
  # def cancele_order
  #   @order = @current_user.orders.find(params[:order_id])
  #   if @order.cancelled!
  #     render_success_response({
  #       order: single_serializer.new(@order , serializer: Api::V1::OrderSerializer).as_json
  #     }, "Order has been cancelled")
  #   else
  #     render_unprocessable_entity_response(@order)
  #   end
  # end

  # soap_action "apply_promo",
  # :args   => {:promo_no => :integer},
  # :return => :xml
  # def apply_promo
  #   @promotion = Promotion.find_by_promo_no(params[:promo_no])
  #   @order = @current_user.current_order
  #   if @order.apply_promo!(@promotion)
  #     render_success_response({}, message: 'Promo Applied!')
  #   else
  #     render_unprocessable_entity("Sorry, the promo code #{params[:promo_no]} is not valid.")
  #   end
  # end

  soap_action "update",
  :args   => {order: {:order_id => :string, status: :integer}},
  :return => {update_response: {:success => :boolean, :message => :string}}
  def update
    order = Order.find_by_order_number(params[:order][:order_id])
    if order&.update(status: params[:order][:status])
      UserMailer.update_order_status(order).deliver_now
      xml_render_success_response('true', "updated successfully.",'' ,"update_response")
    else
      xml_render_success_response('false', "Order not found", '', "update_response")
    end
  end


  private

  def order_params
    params.require(:order).permit(:order_payment_type, order_items_attributes: [:id, :item_master_id, :quantity, :pack_size, :pack_id, :amount, :_destroy], addresses_attributes: [:id, :title, :address, :active, :_destroy])
  end
end
