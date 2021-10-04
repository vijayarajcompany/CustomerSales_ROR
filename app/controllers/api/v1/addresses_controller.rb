class Api::V1::AddressesController < Api::V1::ApiController
  before_action :set_address, only: [:update, :show, :destroy]

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      render_success_response({
                                address: single_serializer.new(@address, serializer: Api::V1::AddressSerializer)
      }, I18n.t('created', resource: 'address'))
    else
      render_unprocessable_entity_response(@address)
    end
  end

  def update
    if @address.update(address_params)
      render_success_response({
                                address: single_serializer.new(@address, serializer: Api::V1::AddressSerializer)
      }, I18n.t('updated', resource: 'address'))
    else
      render_unprocessable_entity_response(@address)
    end
  end

  def destroy
    @address.destroy
    render_success_response({}, I18n.t('destroy', resource: 'address'), status = 200)
  end

  def index
    @addreses = current_user.addresses
    render_success_response({
    address: array_serializer.new(@addreses, serializer: Api::V1::AddressSerializer) },'', 200,)
  end

  def show
    render_success_response({
                              address: single_serializer.new(@address, serializer: Api::V1::AddressSerializer)
    })
  end

  private

  def address_params
    params.require(:address).permit(:title, :address_type, :address, :active, :mobile_number, :category, :alternative_number, :alternative_number_country_code, :mobile_number_country_code)
  end

  def set_address
    @address = Address.find(params[:id])
  end
end
