class Api::Xml::V1::TradeOffersController < ActionController::API
  include ApplicationXmlMethods

  before_action :authenticate_request, only: [:index]

  soap_service namespace: 'urn:WashOut'


  soap_action "create",
    :args   => {:trade_offer=>{:tradeoffer_id => :string, :tradeitem => :string, :startdate => :string, :enddate => :string, :trade_offer_type => :string, :status => :string, :qualif_id => :string, :qualif_desc => :string, :sales_qty => :string, :flex_grp => :string, :flex_desc => :string, :foc_qty => :string}},
    :return => {create_response: {:success => :boolean, :message => :string}}

  def create
    @trade_offer = TradeOffer.new(trade_offer_params)
    if @trade_offer.save
      xml_render_success_response('true', "Created successfully.",'' ,"create_response")
    else
      xml_render_success_response('false', @trade_offer.errors.full_messages.join(', '), '', "create_response")
    end
  end

  private

  def trade_offer_params
    params.require(:trade_offer).permit(:title, :tradeoffer_id, :tradeitem, :startdate , :enddate, :trade_offer_type, :status, :qualif_id, :qualif_desc, :sales_qty, :flex_grp, :flex_desc, :foc_qty, :offer_items)
  end
end
