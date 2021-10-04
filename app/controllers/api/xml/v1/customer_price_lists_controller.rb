class Api::Xml::V1::CustomerPriceListsController < ActionController::API
  include ApplicationXmlMethods

  skip_before_action :authenticate_request, only: [:create], raise: false

  soap_service namespace: 'urn:WashOut'

  soap_action "create",
    :args   => {:customer_price_list=>{:customercode => :string, :itemcode => :string, :startdate => :string, :enddate => :string, :each_sales_price => :string, :carton_sales_price => :string, :delimit => :string}},
    :return => {create_response: {:success => :boolean, :message => :string}}
  def create
    customer_price_list = CustomerPriceList.new(customer_price_list_params)
    if customer_price_list.save
      xml_render_success_response('true', "Created successfully.",'' ,"create_response")
    else
      xml_render_success_response('false', customer_price_list.errors.full_messages.join(', '), '', "create_response")
    end
  end

  private

  def customer_price_list_params
    params.require(:customer_price_list).permit(:customercode, :itemcode, :startdate, :enddate, :each_sales_price, :carton_sales_price, :delimit)
  end
end
