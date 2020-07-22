# frozen_string_literal: true

require 'jwt'

class User::AuthTokensService
  # ISSUER = ENV["PROJECT_NAME"]
  ISSUER = '1XCODER'

  # Encode a hash in a json web token
  def self.encode(payload, ttl)
    payload[:iss] = ISSUER
    payload[:iat] = Time.now.nsec.to_i
    payload[:exp] = ttl.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  # Decode a token and return the payload inside
  # It will throw an error if expired or invalid. See the docs for the JWT gem.
  def self.decode(token, leeway = 30)
    decoded = JWT.decode(
      token,
      Rails.application.secrets.secret_key_base,
      leeway: leeway,
      iss: ISSUER,
      verify_iss: true,
      verify_iat: true,
    )

    HashWithIndifferentAccess.new(decoded.first)
  end
end
