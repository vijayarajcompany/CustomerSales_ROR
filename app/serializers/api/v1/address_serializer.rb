class Api::V1::AddressSerializer < ActiveModel::Serializer
  attributes :id, :title, :address, :latitude, :address, :mobile_number, :category, :longitude, :alternative_number, :alternative_number_country_code, :mobile_number_country_code
end
