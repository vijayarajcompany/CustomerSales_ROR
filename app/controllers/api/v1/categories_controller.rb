class Api::V1::CategoriesController < Api::V1::ApiController
  before_action :authenticate_request, only: [:index, :show]

  def index
#     binding.pry
    categories = send("load_by_#{get_shopping_type}")
    categories = categories.page(params[:page]).per(params[:per])

    render_success_response({
                              categories: array_serializer.new(categories, serializer: Api::V1::CategorySerializer)
    }, "categories Listing", page_meta(categories))
  end

  def load_by_trade_offer
    TradeOffer.find_by(id: params[:trade_offer_id]).categories rescue Category.where(id: "-5")
  end

  def load_by_shop
    Category.all#where(division: current_user.division)
  end

  def get_shopping_type
    if ["trade_offer", "shop"].include? params[:shopping_type]
      return params[:shopping_type]
    else
      return "shop"
    end
  end
end
