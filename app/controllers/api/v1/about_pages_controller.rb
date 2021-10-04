class Api::V1::AboutPagesController < Api::V1::ApiController
  skip_before_action :authenticate_request

  def show

    about_page = AboutPage.last
    if about_page
      render_success_response({
        about_page: single_serializer.new(about_page, serializer: Api::V1::AboutPageSerializer)
      }, status = 200)
    else
      render_unprocessable_entity("About Page not available!")
    end
  end
end
