class Api::V1::PromotionsController < Api::V1::ApiController
  before_action :authenticate_request, only: [:index]

  def index
    promotions = current_user.promotions
    render_success_response({
      promotions: array_serializer.new(promotions, serializer: Api::V1::PromotionsSerializer)
    }, status = 200)
  end

  def apply
    order = Order.find(params[:order_id])
    if order.apply_promo!(promotion)
      render_success_response({
        promotion: single_serializer.new(promotion, serializer: Api::V1::PromotionsSerializer)
      })
    else
      render_unprocessable_entity("Promo not for you!")
    end
  end

  def find_promotion
    promotion = Promotion.find(params[:id])
  end
end
