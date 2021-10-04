module Api
  module Xml
    module V1
      module Users
        class PasswordResetsController < ActionController::API
          include ApplicationXmlMethods
          skip_before_action :authenticate_request, raise: false
          before_action :get_user, only: [:edit, :update]
          before_action :authorised_user, only: [:edit, :update]
          before_action :check_expiration, only: [:edit, :update]
          soap_service namespace: 'urn:WashOut'

          soap_action "create",
          :args   => {:email => :string},
          :return => :xml
          def create
            if params[:email].blank?
              return render_unprocessable_entity(I18n.t('errors.field_empty', { field: 'Email' }))
            end
            user = User.find_by(email: params[:email])
            if user.present?
              user.create_reset_digest
              user.send_password_reset_email
              render_success_response({}, I18n.t('errors.passwords.reset_password_email', {email: params[:email]}))
            else
              render_unprocessable_entity(I18n.t('errors.not_found', { resource: 'User' }))
            end
          end

          def edit
            render json: { message: "ok" }, status: :ok
          end

          soap_action "update",
          :args   => {:password => :string},
          :return => :xml
          def update
            if params[:password].blank?
              render_unprocessable_entity(I18n.t('errors.passwords.present'))
            elsif @user.update_attributes(password: params[:password], password_confirmation: params[:password_confirmation])
              @user.send_password_changed_email
              @user.update_attribute(:reset_digest, nil)
              render_success_response({},I18n.t('errors.passwords.password_reset'))
            end
          end

          private

          def get_user
            @user = User.find_by(email: params[:email])
          end

          def authorised_user
            unless (@user && @user.activated? &&
                      @user.authenticated?(:reset, params[:token]))
              return render_unprocessable_entity(I18n.t('errors.unauthorized'))
            end
          end

          def check_expiration
            return render_unprocessable_entity(I18n.t('errors.passwords.invalid_token')) if @user.password_reset_expired?
          end
        end
      end
    end
  end
end
