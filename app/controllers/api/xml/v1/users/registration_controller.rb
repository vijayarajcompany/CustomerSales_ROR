module Api
  module Xml
    module V1
      module Users
        class RegistrationController < ActionController::API
          include ApplicationXmlMethods
          soap_service namespace: 'urn:WashOut'

          soap_action "create",
            :args   => {:registration=>{:first_name=> :string, :last_name => :string, :email=>:string, :password=>:string, :password_confirmation=> :string, :ern_number =>:string}},
            :return => :xml
          def create
            user = User.find_by(ern_number: registration_params[:ern_number])
            user = User.new(registration_params)
            if user.save
              user.send_confirmation_mail!
              render_success_response({
                registration: single_serializer.new(user, serializer: Api::V1::Users::RegistrationSerializer).as_json
              }, I18n.t('registration.success', resource: 'User'))
            else
              render_unprocessable_entity_response(user)
            end
          end

          private

          def registration_params
            params.require(:registration).permit(:first_name, :last_name, :email, :password, :password_confirmation, :document, :ern_number, :profile_picture)
          end
        end
      end
    end
  end
end
