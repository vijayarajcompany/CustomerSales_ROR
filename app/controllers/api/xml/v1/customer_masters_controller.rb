class Api::Xml::V1::CustomerMastersController < ActionController::API
  include ApplicationXmlMethods

  #skip_before_action :authenticate_request, only: [:create], raise: false

  soap_service namespace: 'urn:WashOut'

  soap_action "create",
    :args   => {:customer_master=>{:customercode => :string, :route => :string, :customername => :string, :address1 => :string, :address2 => :string, :address3 => :string, :city => :string, :telephone => :string, :paymentterms => :string, :creditlimitdays => :string, :creditlimitamount => :string, :activecustomer => :string, :customergroup => :string, :vat => :string, :excise => :string, :tradeoffer_id => :string, :volume_cap => :string, :outstanding_bill => :string, :credit_override => :string, :division => :string, :credit_limit => :string, :credit_exposure => :string, :credit_available => :string}},
    :return => {create_response: {:success => :boolean, :message => :string}}
  def create
    customer_master = CustomerMaster.find_or_create_by(customercode: customer_master_params[:customercode])
    if customer_master.update(customer_master_params)
      xml_render_success_response('true', "Created successfully.",'' ,"create_response")
    else
      xml_render_success_response('false', customer_master.errors.full_messages.join(', '), '', "create_response")
    end
  end

  # soap_action "update_customer_master",
  #   :args   => {:id => :integer, :customer_master=>{:customercode => :string, :route => :string, :customername => :string, :address1 => :string, :address2 => :string, :address3 => :string, :city => :string, :telephone => :string, :paymentterms => :string, :creditlimitdays => :string, :creditlimitamount => :string, :activecustomer => :string, :customergroup => :string, :vat => :string, :excise => :string, :tradeoffer_id => :string, :volume_cap => :string, :outstanding_bill => :string, :credit_override => :string, :division => :string, :credit_limit => :string, :credit_exposure => :string, :credit_available => :string}},
  #   :return => :xml

  # def update_customer_master
  #   @customer_master = CustomerMaster.find(params[:id])
  #   if @customer_master.update(customer_master_params)
  #     render_success_response({
  #         customer_master: single_serializer.new(@customer_master, serializer: Api::V1::CustomerMasterSerializer).as_json
  #       }, I18n.t('updated', resource: 'CustomerMaster'))
  #   else
  #     render_unprocessable_entity_response(@customer_master)
  #   end
  # end

  private

  def customer_master_params
    params.require(:customer_master).permit(:customercode, :route, :customername, :address1, :address2, :address3, :city, :telephone, :paymentterms, :creditlimitdays, :creditlimitamount, :activecustomer, :customergroup, :vat, :excise, :tradeoffer_id, :volume_cap, :outstanding_bill, :credit_override, :division, :credit_limit, :credit_exposure, :credit_available)
  end
end
