class JsonWebToken
  SECRET = ENV['SECRET_KEY_BASE']
  def self.encode(payload)
    payload[:exp] = payload[:exp].to_i
    JWT.encode(payload, SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET)[0]
    HashWithIndifferentAccess.new(body)
  rescue JWT::ExpiredSignature
    nil
  rescue
    nil
  end
end
