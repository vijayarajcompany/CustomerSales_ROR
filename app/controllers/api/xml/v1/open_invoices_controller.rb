class Api::Xml::V1::OpenInvoicesController < ActionController::API
  include ApplicationXmlMethods

  #skip_before_action :authenticate_request, only: [:create], raise: false

  soap_service namespace: 'urn:WashOut'

  soap_action "create",
    :args   => {:open_invoice=>{:customercode => :string, :invoice => :string, :inv_date => :string, :inv_amount => :string, :bal_amount => :string}},
    :return => {create_response: {:success => :boolean, :message => :string}}
  def create
    @open_invoice = OpenInvoice.new(open_invoice_params)
    if @open_invoice.save
      xml_render_success_response(true, "Created successfully.")
    else
      xml_render_success_response('false', @open_invoice.errors.full_messages.join(', '), '', "create_response")
    end
  end

  private

  def open_invoice_params
    params.require(:open_invoice).permit(:customercode, :open_invoices, :invoice, :inv_date, :inv_amount, :bal_amount)
  end
end
