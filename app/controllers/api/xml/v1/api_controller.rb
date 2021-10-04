class Api::Xml::V1::ApiController < ActionController::API
  include ApplicationXmlMethods
  soap_service namespace: 'urn:WashOut'

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
    params[:sort] ? params[:sort] : 'asc'
  end
end
