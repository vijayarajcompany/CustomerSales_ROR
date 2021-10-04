module Api
  module V1
    module Users
      class UsersController < Api::V1::ApiController
        before_action :authenticate_request

        def account_profile
          render_success_response({
            user: single_serializer.new(current_user, serializer: UserSerializer)
          }, status = 200)
        end

        def update_password
          @user = current_user
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
            render_unprocessable_entity([{detail: I18n.t('errors.passwords.current_password', resource: 'User')}])
          end
        end

        def update_profile
          @user = current_user
          if @user.update(user_params)
            render_success_response({
                user: single_serializer.new(@user, serializer: UserSerializer)
              }, I18n.t('updated', resource: 'User'))
          else
            render_unprocessable_entity_response(@user)
          end
        end

        def notification
          @notification = PaperTrail::Version.where(whodunnit: current_user.id)
          render_success_response({
            version: array_serializer.new(@notification, serializer: Api::V1::Users::VersionsSerializer)
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
