# frozen_string_literal: true

class SerializableAuthToken < JSONAPI::Serializable::Resource
  type 'auth_token'

  attributes :token, :refresh_token, :token_expires_at, :refresh_token_expires_at

  belongs_to :tokenable
end
