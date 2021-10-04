class Api::V1::WalletsController < Api::V1::ApiController


	def show_user_wallet
		@wallet = current_user.wallet
		render_success_response({
			  wallet: single_serializer.new(@wallet, serializer: Api::V1::WalletSerializer)
			}, status = 200)
	end
  
end
