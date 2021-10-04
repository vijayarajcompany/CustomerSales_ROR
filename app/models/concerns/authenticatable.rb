module Authenticatable
  extend ActiveSupport::Concern
  included do
    has_secure_password
    attr_accessor :reset_token
    validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, :if => Proc.new { |t| t.has_attribute? "email" }
    validates :password, length: { within: 8..40 }, password: true, allow_nil: true
  end

  def create_reset_digest
    self.reset_token = generate_token
    assign_attributes(reset_digest: digest(reset_token), reset_sent_at: Time.zone.now)
    save(validate: false)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def set_random_passwords
    token = generate_token.to_s
    self.password = token
    self.password_confirmation = token
  end

  private

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end
end
