class Api::Xml::V1::PromotionsController < ActionController::API
  include ApplicationXmlMethods
  before_action :authenticate_request, only: [:index]
  soap_service namespace: 'urn:WashOut'

  soap_action "create",

    :args   => {:promotion=>{:promo_no => :string, :promodescription => :string, :customercode => :string, :active_status => :string, :sales_item => :string, :sale_qty => :string, :foc_item => :string, :sale_uom => :string, :foc_qty => :string, :start_date => :string, :end_date => :string, :promotion_type => :string, :discount_value => :string, :value1 => :string, :value2 => :string, :value3 => :string}},
    :return => {create_response: {:success => :boolean, :message => :string}}



  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      xml_render_success_response('true', "Created successfully.",'' ,"create_response")
    else
      xml_render_success_response('false', @promotion.errors.full_messages.join(', '), '', "create_response")
    end
  end

  private

  def promotion_params
    params.require(:promotion).permit(:discount_amount, :customercode, :active_status, :sales_item, :sale_qty, :foc_item, :sale_uom, :foc_qty, :start_date, :end_date, :promotion_type, :discount_value, :value1, :value2, :value3, :promo_no, :promodescription, :promo_customers, :discount_amount, :expirey_date, promoitems: [])
  end
end
