class Api::V1::BannersController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: [:index]

  def index
    banners = Banner.all.order('created_at ASC')
    render_success_response({
      banner: array_serializer.new(banners, serializer: Api::V1::BannerSerializer)
    }, status = 200)
  end
end
