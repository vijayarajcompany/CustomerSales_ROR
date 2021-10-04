module Api
  module Xml
    module V1
      module Users
        class SessionsController < ActionController::API
          include ApplicationXmlMethods
          
          soap_service namespace: 'urn:WashOut'

          soap_action "create",
            :args   => {:user=>{:email=>:string, :password=>:string, :remember_me=>:srting, :first_name=>:string, :last_name =>:string, :uid=>:string, :provider=>:string, :ern_number=>:string}},
            :return => :xml
          def create
            auth = AuthenticateUser.call(auth_params[:ern_number], auth_params[:email], auth_params[:password], auth_params[:remember_me])
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
end
