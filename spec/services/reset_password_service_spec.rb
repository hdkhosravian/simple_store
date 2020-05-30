# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::ResetPasswordService do
  it 'create user successfully' do
    user        = create(:taken_email)
    hash, token = Devise.token_generator.generate(User, :reset_password_token)
    user.update(reset_password_token: token)

    result = User::ResetPasswordService.new(
      token: hash,
      password: '1234567890',
      password_confirmation: '1234567890',
    ).process

    expect(result[:result]).to eq true
    expect(result[:errors]).to eq({})
    expect(result[:user].reset_password_token).to eq nil
    expect(result[:user].valid_password?('1234567890')).to eq true
  end

  it 'invalid token' do
    result = User::ResetPasswordService.new(
      token: '123456',
    ).process

    expect(result[:result]).to eq false
    expect(result[:errors][:detail]).to include 'invalid reset password token'
  end

  it 'not equal passwords' do
    user        = create(:taken_email)
    hash, token = Devise.token_generator.generate(User, :reset_password_token)
    user.update(reset_password_token: token)

    result = User::ResetPasswordService.new(
      token: hash,
      password: '1234567890',
      password_confirmation: '123456789',
    ).process

    expect(result[:result]).to eq false
    expect(result[:errors][:detail]).to include 'password and password confirmation must be equal'
  end
end
