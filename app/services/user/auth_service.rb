# frozen_string_literal: true

class User::AuthService
  attr_reader :request
  attr_reader :auth_token

  # constructor of class
  # @param request [Request]
  # header is request.headers["Authorization"]
  def initialize(header)
    @auth_token = header
  end

  # create new token for user
  # this method will invalidate last token
  def self.create_token(user, request = nil)
    user.invalidate_auth_token
    user.generate_auth_token
    user.update_tracked_fields(request) if request.present?
    user.save!
  end

  # check user token
  def authenticate_user!
    # prefer to use custom error for something like this and I18N
    raise AuthenticationError, I18n.t('messages.http._401') unless valid_to_proceed?

    @current_user = ::User.find(decoded_auth_token[:user_id])
    @current_user
  end

  # destory user token
  def destroy_session!
    # prefer to use custom error for something like this and I18N
    raise AuthenticationError, I18n.t('messages.http._401') unless valid_to_proceed?

    decoded_auth_token[:user_id]
  end

private

  # check user has access or not for a request
  def valid_to_proceed?
    http_auth_token &&
      decoded_auth_token &&
      decoded_auth_token[:user_id] &&
      valid_token?
  end

  # check user token and validation of token
  def valid_token?
    ::AuthToken.where(
      tokenable_id: decoded_auth_token[:user_id],
      tokenable_type: :User,
    ).newer&.first&.token == http_auth_token
  end

  # decode the token and return the response
  def decoded_auth_token
    @decoded_auth_token ||= ::User::AuthTokensService.decode(http_auth_token)
  end

  # get token from Authorization in header
  def http_auth_token
    return unless auth_token.present?
    return unless auth_token.to_s.split(' ').first.casecmp('bearer').zero?
    return unless auth_token.to_s.split(' ').second.present?

    @http_auth_token ||= auth_token.split(' ').last
  end
end
