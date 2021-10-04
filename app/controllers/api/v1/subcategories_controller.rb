class Api::V1::SubcategoriesController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: [:index]


  def index
    category = Category.find_by_id(params[:category_id])
    @subcategories = Subcategory.where(category_id: params[:category_id])
    # @subcategories = @subcategories.where(promotion_id: params[:promotion_id]) if params[:promotion_id]
    # @subcategories = @subcategories.where(trade_offer_id: params[:trade_offer_id]) if params[:trade_offer_id]
    @subcategories = @subcategories.page(params[:page]).per(params[:per])

    render_success_response({
      subcategories: array_serializer.new(@subcategories, serializer: Api::V1::SubcategoriesSerializer),
      category: single_serializer.new(category, serializer: Api::V1::CategorySerializer)
    }, "Subcategory Listing", page_meta(@subcategories))
  end
end
