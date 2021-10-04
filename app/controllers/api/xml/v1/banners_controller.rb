class Api::Xml::V1::BannersController < ActionController::API
  include ApplicationXmlMethods

  skip_before_action :authenticate_request, only: [:index], raise: false

  soap_service namespace: 'urn:WashOut'

  soap_action "index",
  :return => :xml
  def index
    banners = Banner.all.order('created_at ASC')

    render_success_response({
      banner: array_serializer.new(banners, serializer: Api::V1::BannerSerializer).as_json
    }, status = 200)
  end
end
