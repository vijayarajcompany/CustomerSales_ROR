class Api::V1::EpgPaymentsController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: [:get_payment_details] 
  
  require 'uri'
  require 'net/http'


  def registration
    url = URI("https://demo-ipg.ctdev.comtrust.ae:2443/")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request["accept"] = 'application/json'

    order_id = params["Registration"]["OrderID"].split('-').last(2).join('-') if params["Registration"]["OrderID"].present?
    request.body = "{\n\t\"Registration\": {\n\t\t\"Currency\": \"AED\",\n\t\t\"ReturnPath\": \"http://139.59.55.24/api/v1/epg_payments/get_payment_details\",\n\t\t\"TransactionHint\": \"CPT:Y;VCC:Y;\",\n\t\t\"OrderID\": \"#{order_id}\",\n\t\t\"Store\": \"0000\",\n\t\t\"Terminal\": \"0000\",\n\t\t\"Channel\": \"#{params[:Registration][:Channel]}\",\n\t\t\"Amount\": \"#{params[:Registration][:Amount]}\",\n\t\t\"Customer\": \"#{params[:Registration][:Customer]}\",\n\t\t\"OrderName\": \"#{params[:Registration][:OrderName]}\",\n\t\t\"UserName\":\"#{SecretKey.env(:epg_user_name)}\",\n\t\t\"Password\":\"#{SecretKey.env(:epg_password)}\"\n\t}\n}"
    order_id_id = params["Registration"]["OrderID"].split('-')[1]
    begin
      response = http.request(request)
      body = JSON.parse(response.body)

      if body["Transaction"]["ResponseClassDescription"] == "Success"
        EpgTransaction.create!(order_id: order_id_id, user_id: current_user.id, registration_response: body, transaction_id: body["Transaction"]["TransactionID"], customer_name: params["Registration"]["Customer"])
        render_success_response(body, "Registration successful.")
      else
        render_unprocessable_entity("Registration failed!")
      end     
    rescue Exception => e
      puts "ERROR: ===============#{e}====================="
    end
  end

  def get_payment_details
    epg_transaction = EpgTransaction.find_by(transaction_id: params["TransactionID"])

    if epg_transaction.present?
      url = URI("https://demo-ipg.ctdev.comtrust.ae:2443/")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["content-type"] = 'application/json'
      request["accept"] = 'application/json'
      request.body = "{\n\"Finalization\": {\n\"TransactionID\": \"#{epg_transaction.transaction_id}\",\n\"Customer\": \"#{epg_transaction.customer_name}\",\n\"UserName\":\"#{SecretKey.env(:epg_user_name)}\",\n\"Password\":\"#{SecretKey.env(:epg_password)}\"\n}\n}"

      begin
        response = http.request(request)
        body = JSON.parse(response.body)

        Rails.logger.info "ERROR: ===============\n #{body} \n====================="

        if body["Transaction"]["ResponseClassDescription"] == "Success"
          order = epg_transaction.order
          place_order = order.place_order!
        end

        epg_transaction.update!(payment_response: body, status: body["Transaction"]["ResponseClassDescription"])
       
      rescue Exception => e
        Rails.logger.info "ERROR: ===============#{e}====================="
      end
    end
    redirect_to "#{ENV['FRONTEND_HOST']}/order/order-place?transaction_id=#{epg_transaction.transaction_id}&status=#{body["Transaction"]["ResponseClassDescription"]}"
    # render html: '<div>We are redirecting to payment response.</div>'.html_safe
  end

  def epg_payment_response
    if params[:transaction_id].present?
      epg_response = EpgTransaction.find_by(transaction_id: params[:transaction_id])
      if epg_response&.payment_response.present?
        if epg_response.payment_response["Transaction"]["ResponseCode"] == "0"
          render_success_response(epg_response.payment_response, "Payment successful.")
        else
          render_unprocessable_entity(epg_response.payment_response["Transaction"]["ResponseDescription"])
        end
      else
        render_unprocessable_entity("Waiting for EPG Payment response.")
      end
    else
      render_unprocessable_entity("Please send TransactionID in params.")
    end
  end
end