class Api::Xml::V1::SubcategoriesController < ActionController::API
  include ApplicationXmlMethods
  include Pagination
  skip_before_action :authenticate_request, only: [:index], raise: false

  soap_service namespace: 'urn:WashOut'

  soap_action "index",
  :args => {:category_id => :integer, :page => :integer, :per => :integer},
  :return => :xml
  def index
    category = Category.find_by_id(params[:category_id])
    @subcategories = Subcategory.where(category_id: params[:category_id])
    # @subcategories = @subcategories.where(promotion_id: params[:promotion_id]) if params[:promotion_id]
    # @subcategories = @subcategories.where(trade_offer_id: params[:trade_offer_id]) if params[:trade_offer_id]
    @subcategories = @subcategories.page(params[:page]).per(params[:per])

    render_success_response({
      subcategories: array_serializer.new(@subcategories, serializer: Api::V1::SubcategoriesSerializer).as_json,
      category: single_serializer.new(category, serializer: Api::V1::CategorySerializer)
    }, "Subcategory Listing").as_json
  end
end
