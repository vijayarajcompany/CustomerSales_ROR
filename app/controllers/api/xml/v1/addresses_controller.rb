class Api::Xml::V1::AddressesController < ApplicationController


  soap_service namespace: 'urn:WashOut'

  soap_action "create",
    :args   => {:address=>{:customercode => :string, :title => :string, :address => :string, :mobile_number => :string, :category => :string}},
    :return => {create_response: {:success => :boolean, :message => :string}}
  def create
    user = User.find_by_erp_number(params[:customer_master][:customercode])
    address = Address.new(address_params)
    address.addressable = user
    if address.save
      xml_render_success_response('true', "Created successfully.",'' ,"create_response")
    else
      xml_render_success_response('false', address.errors.full_messages.join(', '), '', "create_response")
    end
  end


  private

  def address_params
    params.require(:address).permit(:title, :address_type, :address, :active, :mobile_number, :category)
  end
end
