class Api::V1::DivisionsController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: [:index]
  def index
    division = Division.all.order('created_at ASC')

    render_success_response({
      division: array_serializer.new(division, serializer: Api::V1::DivisionSerializer)
    }, status = 200)
  end
end