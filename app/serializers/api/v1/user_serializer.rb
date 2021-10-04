class Api::V1::UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :first_name, :last_name, :email, :company_id, :activated, :profile_picture, :ern_number, :created_at, :division, :cart_item_count, :user_type
end
