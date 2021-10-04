class Api::V1::TradeOffersController < Api::V1::ApiController
  before_action :authenticate_request, only: [:index]

  def index
    trade_offers = current_user.trade_offers
    render_success_response({
      trade_offers: array_serializer.new(trade_offers, serializer: Api::V1::TradeOfferSerializer)
    }, status = 200)
  end
end
