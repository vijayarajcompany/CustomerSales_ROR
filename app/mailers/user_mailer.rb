class UserMailer < ApplicationMailer
  default from: ENV['BACKEND_EMAIL_USERNAME'] || 'custorder@pepsidrc.ae'

  def registration_confirmation(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to PepsiDRC')
  end

  def password_reset(user, reset_token)
    @user = user
    @reset_token = reset_token
    mail(to: user.email, subject: 'Password reset')
  end

  def password_changed(user)
    @user = user
    mail(to: user.email, subject: 'Password changed')
  end

  def after_confirmation(user)
    @user = user
    mail(to: AdminUser.pluck(:email) - ['admin@example.com'], subject: 'New user is waiting for Activation.')
  end

  def activated(user)
    @user = user
    mail(to: @user.email, subject: 'Your account has been activated')
  end

  def update_order_status(order)
    @user = order.user
    @order = order
    mail(to: @user.email, subject: "Your Order #{order.order_number} status has been updated")
  end

  def order_placed(order)
    @user = order.user
    @order = order
    mail(from: 'custorder@pepsidrc.ae', to: @user.email, subject: "Your Order #{order.order_number} Has Been Placed Successfully.")
  end
end
