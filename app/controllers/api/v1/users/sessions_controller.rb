module Api
  module V1
    module Users
      class SessionsController < Api::V1::ApiController
        skip_before_action :authenticate_request

        def create
          auth = AuthenticateUser.call(auth_params[:ern_number], auth_params[:email].downcase, auth_params[:password], auth_params[:remember_me])
          if auth.success?
            render_success_response({response: auth.result, invited_feature: params[:invited_feature] || ''})
          else
            error_response = auth.errors[:user_authentication][0]
            render_unprocessable_entity(I18n.t(error_response))
          end
        end

        def social_media_login
          auth = OAuthAuthenticateUser.call(auth_params[:email], auth_params[:first_name], auth_params[:last_name], auth_params[:uid], auth_params[:provider])
          if auth.success?
            render_success_response({response: auth.result})
          else
            error_response = auth.errors[:user_authentication][0]
            render_unprocessable_entity(I18n.t(error_response))
          end
        end

        private

        def auth_params
          params.require(:user).permit(:email, :password, :remember_me, :first_name, :last_name, :uid, :provider, :ern_number)
        end
      end
    end
  end
end
