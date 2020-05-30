# frozen_string_literal: true

module AuthenticationHelper
  def sign_in(user)
    post  api_v1_users_sessions_url,
          params: {
            'email': user.email,
            'password': user.password,
          }
    body   = JSON.parse(response.body)
    @token = body['included'][0]['attributes']['token']
    response
  end

  def token
    @token
  end

  def auth_header
    {
      Authorization: "Bearer #{token}",
    }
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper
end
