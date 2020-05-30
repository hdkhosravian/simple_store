# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::AuthService do
  it 'check token validation for authentication' do
    user = create(:user)
    ttl  = 10_000.hour.from_now

    ::User::AuthService.create_token(user)
    authentication = ::User::AuthService.new("bearer #{user.token.token}").authenticate_user!

    expect(authentication.id).to eq user.id
    expect(authentication.email).to eq user.email
  end

  it 'check token validation for logout' do
    user = create(:user)
    ttl  = 10_000.hour.from_now

    ::User::AuthService.create_token(user)
    authentication = ::User::AuthService.new("bearer #{user.token.token}").destroy_session!

    expect(authentication).to eq user.id
  end

  it 'deprecated auth token' do
    user = create(:user)
    ttl  = 1.days.ago

    encode = ::User::AuthTokensService.encode(
      { user_id: user.id, created_at: Time.zone.now, expire_at: ttl.to_time },
      ttl,
    )

    expect do
      ::User::AuthService.new("bearer #{encode}").authenticate_user!
    end.to raise_error(JWT::ExpiredSignature)
  end

  it 'invalid auth token' do
    expect do
      ::User::AuthService.new('bearer 123456aA').authenticate_user!
    end.to raise_error(JWT::DecodeError)
  end
end
