class Api::V1::BrandsController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: [:index, :show]
  
  def index
    brands = Brand.all

    render_success_response({
      brand: array_serializer.new(brands, serializer: Api::V1::BrandSerializer)
    }, 'brand Listing')
  end
end
