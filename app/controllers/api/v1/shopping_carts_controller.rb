class Api::V1::ShoppingCartsController < Api::V1::ApiController
  before_action :authenticate_request, expect: [:setting]
  skip_before_action :authenticate_request, only: [:setting]
  before_action :set_paper_trail_whodunnit

  def setting
    setting = Setting.last
    render_success_response({
    setting: Setting.last.as_json(only: [:minimun_amount, :shipping_charge])})
  end

  def index
    orders = current_user.orders.where.not(status: 0).order('created_at DESC')
    @orders = orders.page(params[:page]).per(params[:per])
    render_success_response({
                              orders: array_serializer.new(@orders, serializer: Api::V1::OrderSerializer)
    }, "orders Listing", page_meta(@orders))
  end

  def show_current
    @order = current_user.current_order
    render_success_response({
                              order: single_serializer.new(@order, serializer: Api::V1::OrderSerializer)
    })
  end

  def show
    @order = Order.find(params[:id])
    render_success_response({
                              order: single_serializer.new(@order, serializer: Api::V1::OrderSerializer)
    })
  end

  def add_address
    @order = current_user.current_order
    @address = @order.current_address
    if @address.update(address_params)
      render_success_response({
                                addres: single_serializer.new(@address , serializer: Api::V1::AddressSerializer)
      }, I18n.t('updated', resource: 'addres '))
    else
      render_unprocessable_entity_response(@addres)
    end
  end

  def add_order_items
    @order = current_user.current_order
    if @order.update(order_params)
      render_success_response({
                                order: single_serializer.new(@order , serializer: Api::V1::OrderSerializer)
      }, I18n.t('updated', resource: 'order '))
    else
      render_unprocessable_entity_response(@order)
    end
  end

  def place_order
    @order = current_user.current_order
    @order.update(order_params)
    place_order = @order.place_order!
    if place_order.valid?
      render_success_response({
                                order: single_serializer.new(@order , serializer: Api::V1::OrderSerializer)
      }, 'Order has been placed. It will be delivered within 24 to 48 hours.')
    else
      render_unprocessable_entity([{error: @order.reload.sap_errors, detail: @order.reload.sap_errors}])
    end
  end

  def cancele_order
    @order = current_user.orders.find(params[:order_id])
    if @order.cancelled!
      render_success_response({
                                order: single_serializer.new(@order , serializer: Api::V1::OrderSerializer)
      }, "Order has been cancelled")
    else
      render_unprocessable_entity_response(@order)
    end
  end

  def apply_promo
    @promotion = Promotion.find_by_promo_no(params[:promo_no])
    @order = current_user.current_order
    if @order.apply_promo!(@promotion)
      render_success_response({}, message: 'Promo Applied!')
    else
      render_unprocessable_entity("Sorry, the promo code #{params[:promo_no]} is not valid.")
    end
  end

  def remove_promo
    @order = current_user.current_order
    if @order.remove_promo!
      render_success_response({}, message: 'Promo Remove!')
    end
  end

  def order_item_destroy
    order_item = OrderItem.find(params[:id])
    order_item.destroy
    render_success_response({}, 'Order item removed!')
  end

  private

  def order_params
    params.require(:order).permit(:shopping_type, :trade_offer_id, order_items_attributes: [:id, :item_master_id, :shopping_type, :quantity, :pack_size, :trade_offer_id, :amount, :_destroy], addresses_attributes: [:id, :title, :address_type, :address, :active, :mobile_number, :category, :alternative_number, :alternative_number_country_code, :mobile_number_country_code, :_destroy])
  end

  def address_params
    params.require(:address).permit(:id, :title, :address_type, :address, :active, :mobile_number, :category, :alternative_number, :alternative_number_country_code, :mobile_number_country_code)
  end
end
