class AuthenticateUser < ApplicationService
  def initialize(ern_number, email, password, remember_me = false)
    @ern_number = ern_number if ern_number.present?
    @email = email if email.present?
    @password = password
    @remember_me = remember_me
  end

  private

  attr_accessor :email, :password, :remember_me, :ern_number

  def call
    expiry = remember_me ? 30.days.from_now : 24.hours.from_now
    user ||= authenticate_user
    if user
      user.update(last_login: Time.zone.now)
      { token: JsonWebToken.encode(user_id: user.id, exp: expiry, user_type: 'User'), user: allowed_attributes(user) }
    end
  end

  def authenticate_user
    user = User.find_by({ern_number: ern_number, email: email}.compact)
    if user.present?
      if user.confirm?
        if user.activated
          if ((user.home_delivery?) || (user.business_customer? && user.ern_number?))
            if user&.authenticate(password)
              return user
              # if user.division.present?
              #   return user
              # else
              #   errors.add :user_authentication, 'errors.add_division'
              # end
            else
              errors.add :user_authentication, 'errors.invalid_credentials'
            end
          else
            errors.add :user_authentication, 'errors.add_ern'
          end
        else
          errors.add :user_authentication, 'errors.not_activated'
        end
      else
        errors.add :user_authentication, 'errors.unconfirmed_account'
      end
    else
      errors.add :user_authentication, 'errors.account_not_found'
    end
  end

  def allowed_attributes(user)
    JSON.parse(user.to_json(except: ['password_digest', 'confirm_token', 'reset_digest'], methods: ['cart_item_count']))
  end
end
