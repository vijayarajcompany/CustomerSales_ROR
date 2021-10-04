module Api
  module Xml
    module V1
      module Users
        class ConfirmationsController < ActionController::API
          include ApplicationXmlMethods
          skip_before_action :authenticate_request, raise: false
          soap_service namespace: 'urn:WashOut'
          soap_action "show",
          :args   => {:token => :string},
          :return => :xml
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
end
