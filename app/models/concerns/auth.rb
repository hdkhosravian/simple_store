# frozen_string_literal: true

module Auth
  # return first association auth_token model
  def token
    auth_tokens.newer.first
  end

  # generate and asign token and refresh token to Model with AuthToken Model
  # Class.generate_auth_token '127.0.0.1'
  # Class.auth_tokens.token # => eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJhdXRoX3R
  # Class.auth_tokens.refresh_token # => ab9239a532e59a164e1e9a319d5c
  # ttl = ENV['AUTH_TOKEN_TTL'].to_i
  # change ttl to ttl = ENV["AUTH_TOKEN_TTL"]
  # change refresh_ttl to ttl = ENV["AUTH_REFRESH_TOKEN_TTL"]
  def generate_auth_token(ttl = 10_000, refresh_ttl = '30000')
    ttl = ttl.to_i.hour.from_now
    refresh_ttl = refresh_ttl.to_i.hour.from_now

    auth_token = auth_tokens.build

    auth_token.token = ::User::AuthTokensService.encode(
      { user_id: id, created_at: Time.zone.now, expire_at: ttl.to_time },
      ttl,
    )
    auth_token.token_expires_at = ttl

    auth_token.refresh_token = generate_refresh_token
    auth_token.refresh_token_expires_at = refresh_ttl
  end

  # invalidate current token and refresh token
  def invalidate_auth_token
    exp = Time.zone.now
    return false if auth_tokens.empty?

    auth_token = token

    auth_token.token = ::User::AuthTokensService.encode({ user_id: id }, exp)
    auth_token.token_expires_at = 1.days.ago
    auth_token.refresh_token_expires_at = 1.days.ago
    auth_token.save!
  end

private

  # generate random string for refresh token
  def generate_refresh_token
    Digest::MD5.hexdigest(Time.zone.now.to_s) + SecureRandom.hex
  end
end
