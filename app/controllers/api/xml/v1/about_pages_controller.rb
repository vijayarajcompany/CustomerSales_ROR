class Api::Xml::V1::AboutPagesController < ActionController::API
  include ApplicationXmlMethods
  skip_before_action :authenticate_request, only: [:show], raise: false
  soap_service namespace: 'urn:WashOut'

  soap_action "show",
  :return => :xml
  def show
    about_page = AboutPage.last
    if about_page
      render_success_response({
        about_page: single_serializer.new(about_page, serializer: Api::V1::AboutPageSerializer).as_json
      }, status = 200)
    else
      render_unprocessable_entity("About Page not available!")
    end
  end
end
