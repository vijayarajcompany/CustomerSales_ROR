module Api
  module V1
    module Users
      class RegistrationController < Api::V1::ApiController
        skip_before_action :authenticate_request

        def create
          # user = User.find_by(ern_number: registration_params[:ern_number])
          user = User.new(registration_params)
          if user.save
            user.send_confirmation_mail!
            render_success_response({
                                      registration: single_serializer.new(user, serializer: RegistrationSerializer)
            }, I18n.t('registration.success', resource: 'User'))
          else
            render_unprocessable_entity_response(user)
          end
        end

        private

        def registration_params
          params.require(:registration).permit(:user_type, :first_name, :last_name, :password, :password_confirmation, :document, :ern_number, :profile_picture).merge({email: params[:registration][:email]&.downcase})
        end
      end
    end
  end
end
