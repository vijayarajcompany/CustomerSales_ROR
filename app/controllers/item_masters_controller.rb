class ItemMastersController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: [:search, :index, :show]

  def index
    if Subcategory.find_by(id: params.dig(:subcategory_id))
      item_masters = Subcategory.find_by(id: params[:sub_category_id]).item_masters
    else
      item_masters = ItemMaster.all
    end
    byebug
    render_success_response({
                              item_masters: array_serializer.new(item_masters, serializer: ItemMasterSerializer, scope: {current_user: current_user}),
                              cart_object_type: order_detail
    }, status = 200)
  end

  def search
    # search = params[:query] || "*"
    # conditions = {}
    # conditions[:brand_name] = params[:brand_name] if params[:brand_name].present?
    # conditions[:category_name] = params[:category_name] if params[:category_name].present?

    # if params[:lte].present? && params[:gte].present?
    #   conditions[:price] = {gte: params[:gte], lte: params[:lte]}
    # end

    # outcome = Product.search search, where: conditions

    # render_success_response({
    #   results: array_serializer.new(outcome.results, serializer: ProductSerializer)
    # }, status = 200)
  end

  def order_detail
    current_user.current_order.as_json(only: [:trade_offer_id, :shopping_type])
  end
end
