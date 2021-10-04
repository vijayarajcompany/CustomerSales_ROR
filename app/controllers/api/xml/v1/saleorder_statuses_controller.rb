class Api::Xml::V1::SaleorderStatusesController < ActionController::API
  include ApplicationXmlMethods

  skip_before_action :authenticate_request, only: [:update], raise: false

  soap_service namespace: 'urn:WashOut'

  soap_action "update",
    :args   => {:id => :integer, :saleorder_status=>{:sale_orderid => :string, :target => :string, :order_status => :string}},
    :return => :xml

  def update
    @saleorder_status = SaleorderStatus.find(params[:id])
    if @saleorder_status.update(saleorder_status_params)
      render_success_response({
          saleorder_status: single_serializer.new(@saleorder_status, serializer: Api::V1::SaleorderStatusSerializer).as_json
        }, I18n.t('updated', resource: 'SaleorderStatus'))
    else
      render_unprocessable_entity_response(@saleorder_status)
    end
  end

  private

  def saleorder_status_params
    params.require(:saleorder_status).permit(:sale_orderid, :target, :order_status)
  end
end
