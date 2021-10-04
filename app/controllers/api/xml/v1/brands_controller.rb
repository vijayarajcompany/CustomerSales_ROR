class Api::Xml::V1::BrandsController < ActionController::API
  include ApplicationXmlMethods

  skip_before_action :authenticate_request, only: [:index], raise: false

  soap_service namespace: 'urn:WashOut'

  soap_action "index",
  :return => :xml
  def index
    brands = Brand.all

    render_success_response({
      brand: array_serializer.new(brands, serializer: Api::V1::BrandSerializer).as_json
    }, 'brand Listing')
  end
end
