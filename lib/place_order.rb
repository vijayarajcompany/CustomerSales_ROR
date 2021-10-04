require 'uri'
require 'net/http'

class PlaceOrder
  attr_accessor :order, :user, :result

  def initialize(order = nil)
    @order = order
    @user = order.user
    @result = {}
  end

  def execute!
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'text/xml'
    request["soapaction"] = 'http://pepsidrc.com/ERP/Standard/SaleOrder'
#   request.basic_auth ENV['SAP_USERNAME'], ENV['SAP_PASSWORD']
    request.basic_auth '13314', 'Builder123'
    request.body = body
    response = http.request(request)
    response_in_hash = Hash.from_xml(response.read_body) rescue {}
    @result[:response_body] =  response_in_hash.dig('Envelope', 'Body', 'MT_SaleOrder_Response', 'SaleOrderResponse') || response_in_hash.dig('Envelope', 'Body', 'Fault', 'detail', 'SystemError', 'text') || 'Due to connection issue, order not place, try after sometime.'
    @result[:response_status] = response_in_hash.dig('Envelope', 'Body', 'MT_SaleOrder_Response', 'StatusFlag')
    update_order!
    self
  end

  def update_order!
    if valid?
      user.wallet.deduct_amount!(order.total_amount || 0)
      order.update(order_number: result[:response_body])
      order.update(place_order_date: DateTime.now)
      order.placed!
      order.order_items.map(&:placed!)
      UserMailer.order_placed(order).deliver_now
    else
      order.update(sap_errors: result[:response_body])
      # order.errored!
    end
  end

  def valid?
    @result[:response_status] == 'S'
  end

  def url

#     URI(ENV['SAP_CONNECTION_URL'])
#     Quality:
        URI('https://custorder.pepsidrc.ae/order')
  end

  def body
    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">
      <soap:Body>
        <ns0:MT_SaleOrder xmlns:ns0=\"http://pepsidrc.com/ERP/Standard/SaleOrder\">
          #{customer_string}
          #{sale_order_item_string}
        </ns0:MT_SaleOrder>
      </soap:Body>
    </soap:Envelope>"
  end

  def customer_string
    "<SaleOrderHeader>
      <CUSTOMERCODE>#{user.ern_number}</CUSTOMERCODE>
      <SALES_ORG>DR01</SALES_ORG>
      <DISTR_CHAN>10</DISTR_CHAN>
      <DIVISION>#{user.division}</DIVISION>
      <DELIVERYDATE>#{order.delivery_date}</DELIVERYDATE>
      <SOURCE>#{order.order_payment_type}</SOURCE>
      <LPO>?</LPO>
      <CREATEDBY>#{user.created_by_sap}|#{order.created_by_sap}</CREATEDBY>
      <SENDER>Builder</SENDER>
    </SaleOrderHeader>"
  end

  def sale_order_item_string
    order.order_items.map do |ot|
      tradeoffer_id = TradeOffer.find_by_id(ot.trade_offer_id)&.tradeoffer_id
      "<SaleOrderItem>
        <ITEMCODE>#{ot.item_master.itemcode}</ITEMCODE>
        <QUANTITY>#{ot.quantity}</QUANTITY>
        <OFFER_FLAG></OFFER_FLAG>
        <PROMOID></PROMOID>
        <OFFERID>#{tradeoffer_id}</OFFERID>
      </SaleOrderItem>"
    end.join('')
  end
end
