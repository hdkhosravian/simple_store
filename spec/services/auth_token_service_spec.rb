# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::AuthTokensService do
  it 'create valid auth token' do
    user = create(:user)
    ttl  = 10_000.hour.from_now

    encode = ::User::AuthTokensService.encode(
      { user_id: user.id, created_at: Time.zone.now, expire_at: ttl.to_time },
      ttl,
    )

    decode = ::User::AuthTokensService.decode(encode)

    expect(decode[:user_id]).to eq user.id
  end

  it 'deprecated auth token' do
    user = create(:user)
    ttl  = 1.days.ago

    encode = ::User::AuthTokensService.encode(
      { user_id: user.id, created_at: Time.zone.now, expire_at: ttl.to_time },
      ttl,
    )

    expect do
      ::User::AuthTokensService.decode(encode)
    end.to raise_error(JWT::ExpiredSignature)
  end

  it 'invalid auth token' do
    expect do
      ::User::AuthTokensService.decode('123456aA')
    end.to raise_error(JWT::DecodeError)
  end
end
