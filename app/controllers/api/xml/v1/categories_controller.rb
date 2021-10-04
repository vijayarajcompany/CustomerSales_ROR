class Api::Xml::V1::CategoriesController < ActionController::API
  include ApplicationXmlMethods
  include Pagination

  before_action :authenticate_request, only: [:index]
  
  soap_service namespace: 'urn:WashOut'

  soap_action "index",
  :args   => {:page => :integer, :per => :integer},
  :return => :xml
  def index
    categories = Category.where(division: @current_user.division)
    categories = categories.page(params[:page]).per(params[:per])

    render_success_response({
      categories: array_serializer.new(categories, serializer: Api::V1::CategorySerializer).as_json
    }, "categories Listing", page_meta(categories))
  end
end
