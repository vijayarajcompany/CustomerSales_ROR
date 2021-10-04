module Api
  module V1
    module Users
      class ConfirmationsController < Api::V1::ApiController
        skip_before_action :authenticate_request

        def show
          user = User.find_by_confirm_token(params[:token])
          if user
            user.confirm!
            render_success_response({},I18n.t('errors.confirmations.account_confirmed'))
          else
            render_unprocessable_entity(I18n.t('errors.not_found', {resource: 'User'}))
          end
        end
      end
    end
  end
end
