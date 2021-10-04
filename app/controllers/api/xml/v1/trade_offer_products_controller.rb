class Api::Xml::V1::TradeOfferProductsController < ActionController::API
  include ApplicationXmlMethods

  before_action :authenticate_request, only: [:index]

  soap_service namespace: 'urn:WashOut'

  soap_action "create",
    :args   => {:tradeoffer_products=>{:group_id => :string, :itemcode => :string}},
    :return => {create_response: {:success => :boolean, :message => :string}}

  def create
    @tradeoffer_product = TradeofferProduct.new(tradeoffer_product_params)
    if @tradeoffer_product.save
      xml_render_success_response('true', "Created successfully.",'' ,"create_response")
    else
      xml_render_success_response('false', @tradeoffer_product.errors.full_messages.join(', '), '', "create_response")
    end
  end

  private

  def tradeoffer_product_params
    params.require(:tradeoffer_products).permit(:group_id, :itemcode)
  end
end
