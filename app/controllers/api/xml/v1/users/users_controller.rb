module Api
  module Xml
    module V1
      module Users
        class UsersController < ActionController::API
          include ApplicationXmlMethods
          #before_action :authenticate_request
          soap_service namespace: 'urn:WashOut'

          soap_action "account_profile",
            :return => :xml
          def account_profile
            render_success_response({
              user: single_serializer.new(@current_user, serializer: Api::V1::Users::UserSerializer).as_json
            }, status = 200).as_json
          end
          
          def update_password
            @user = @current_user
            if @user.authenticate(params[:user][:current_password])
              if params[:user][:password].blank?
                render_unprocessable_entity(I18n.t('errors.passwords.present'))
              elsif @user.update(password_change_params)
                @user.send_password_changed_email
                render_success_response({
                  user: single_serializer.new(@user, serializer: UserSerializer)
                }, I18n.t('updated', resource: 'User'))
              else
                render_unprocessable_entity_response(@user)
              end
            else
              render_unprocessable_entity(I18n.t('errors.passwords.current_password', resource: 'User')).as_json
            end
          end
          soap_action "update_profile",
            :args   => {:user=>{:first_name=> :string, :last_name => :string, :email=>:string, :profile_picture=>:string, :division=>:string}},
            :return => :xml
          def update_profile
            @user = @current_user
            if @user.update(user_params)
              render_success_response({
                  user: single_serializer.new(@user, serializer: Api::V1::Users::UserSerializer).as_json
                }, I18n.t('updated', resource: 'User'))
            else
              render_unprocessable_entity_response(@user)
            end
          end
          soap_action "create",
            :args   => {:user=>{:first_name=> :string, :last_name => :string, :email=>:string, :profile_picture=>:string, :division=>:string}},
            :return => :xml

          def create
            if @user = User.create(user_params)
              render_success_response({
                  user: single_serializer.new(@user, serializer: Api::V1::Users::UserSerializer).as_json
                }, I18n.t('created', resource: 'User'))
            else
              render_unprocessable_entity_response(@user)
            end
          end

          def notification
            @notification = PaperTrail::Version.where(whodunnit: @current_user.id)
            render_success_response({
              version: array_serializer.new(@notification, serializer: Api::V1::Users::VersionsSerializer).as_json
            }, status = 200)

          end

          private

          def password_change_params
            params.require(:user).permit(:password, :password_confirmation)
          end

          def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :profile_picture, :division)
          end
        end
      end
    end
  end
end
