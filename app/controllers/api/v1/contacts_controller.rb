class Api::V1::ContactsController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: [:create]

  def create
    contact = Contact.create(email: params[:email])

    render_success_response({
      contact: single_serializer.new(contact, serializer: Api::V1::ContactSerializer)
    }, status = 200)
  end
end
