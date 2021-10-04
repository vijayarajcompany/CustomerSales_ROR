class Api::Xml::V1::OrderItemsController < ActionController::API
  include ApplicationXmlMethods
  soap_service namespace: 'urn:WashOut'

  soap_action "update",
  :args   => {order: {:order_item_id => :string, status: :integer}},
  :return => {update_response: {:success => :boolean, :message => :string}}
  def update
    order_item = OrderItem.find_by_order_number(params[:order][:order_item_id])
    if order_item&.update(status: params[:order][:status])
      xml_render_success_response('true', "updated successfully.",'' ,"update_response")
    else
      xml_render_success_response('false', "Order Item not found", '', "update_response")
    end
  end

end
