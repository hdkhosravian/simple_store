# frozen_string_literal: true

module Authentication
  def refresh_user!(token, request)
    auth_token = AuthToken.find_by(refresh_token: token)
    # refresh token expires
    # prefer to use custom error for something like this and I18N
    if check_refresh_token_validations(auth_token)
      raise AuthenticationError, I18n.t('messages.authentication.refresh_token')
    end

    user = auth_token.tokenable
    User::AuthService.create_token(user, request)
    user
  end

  # invalidate all session
  def logout_user!
    user_id = ::User::AuthService.new(request.headers['Authorization']).destroy_session!
    user = ::User.includes(:auth_tokens).find_by_id(user_id)
    user.invalidate_auth_token
  end

  # authenticate current request
  def authenticate!
    @current_user = ::User::AuthService.new(request.headers['Authorization']).authenticate_user!
  end

  # return current authenticated user
  def current_user
    @current_user
  end

  def check_refresh_token_validations(auth_token)
    auth_token.nil? ||
      auth_token.refresh_token_expires_at.nil? ||
      auth_token.refresh_token_expires_at.to_date <= Time.zone.now
  end
end
