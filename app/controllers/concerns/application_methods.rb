module ApplicationMethods
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
    around_action :handle_exceptions
  end

  private

  # Catch exception and return JSON-formatted error
  def handle_exceptions
    begin
      yield
    rescue CanCan::AccessDenied => e
      render_unauthorized_response && return
    rescue ActiveRecord::RecordNotFound => e
      @status = 404
    rescue ActiveRecord::RecordInvalid => e
      render_unprocessable_entity_response(e.record) && return
    rescue ArgumentError => e
      @status = 400
    rescue StandardError => e
      @status = 500
    end
    detail = {detail: e.try(:message)}
    detail.merge!(trace: e.try(:backtrace))
    json_response({ success: false, message: e.class.to_s, errors: [detail] }, @status) unless e.class == NilClass
  end

  def render_unprocessable_entity_response(resource)
    json_response({
      success: false,
      message: 'Validation failed',
      meta: {},
      errors: ValidationErrorsSerializer.new(resource).serialize
    }, 422)
  end

  def render_unprocessable_entity(message)
    json_response({
      success: false,
      meta: {},
      errors: message
    }, 422) and return true
  end

  def render_success_response(resources = {}, message = "", meta = {}, status = 200)
    json_response({
      success: true,
      message: message,
      data: resources,
      meta: meta
    }, status)
  end


  def xml_render_success_response(message = "", status = 200)
    json_response({
      message: message,
    }, status)
  end


  def json_response(options = {}, status = 500)
    render json: JsonResponse.new(options), status: status
  end

  def render_unauthorized_response
    json_response({
      success: false,
      message: 'You are not authorized.'
    }, 401)
  end

  def array_serializer
    ActiveModel::Serializer::CollectionSerializer
  end

  def single_serializer
    ActiveModelSerializers::SerializableResource
  end

end
