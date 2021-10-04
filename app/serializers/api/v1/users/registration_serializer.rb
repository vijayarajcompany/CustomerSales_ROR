module Api
  module V1
    module Users
      class RegistrationSerializer < ActiveModel::Serializer
        attributes :first_name, :last_name, :email, :activated, :user_type
      end
    end
  end
end
