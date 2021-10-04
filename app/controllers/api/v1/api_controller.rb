class Api::V1::ApiController < ActionController::API
  include ApplicationMethods
  include Pagination

  attr_reader :current_user, :current_company

  def per_page
    10
  end

  private

  def authenticate_request
    auth = AuthorizeApiRequest.call(request.headers)
    @current_user = auth.result
    render_unauthorized_response and return unless @current_user
  end

  def sort_by
    params[:sort_by] ? params[:sort_by] : 'asc'
  end
end
