class Api::Xml::V1::DivisionsController < ActionController::API
  include ApplicationXmlMethods
  skip_before_action :authenticate_request, only: [:index], raise: false
  
  soap_service namespace: 'urn:WashOut'

  soap_action "index",
  :return => :xml
  def index
  	division = Division.all.order('created_at ASC')
  	render_success_response({
  	  division: array_serializer.new(division, serializer: Api::V1::DivisionSerializer).as_json
  	}, status = 200)
  end
end