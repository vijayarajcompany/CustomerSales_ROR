class Api::Xml::V1::WalletsController < ActionController::API
	include ApplicationXmlMethods

	before_action :authenticate_request

	soap_service namespace: 'urn:WashOut'

  soap_action "show_user_wallet",
  	:return => :xml
	def show_user_wallet
		@wallet = @current_user.wallet
		render_success_response({
			  wallet: single_serializer.new(@wallet, serializer: Api::V1::WalletSerializer).as_json
			}, status = 200)
	end
  
end
