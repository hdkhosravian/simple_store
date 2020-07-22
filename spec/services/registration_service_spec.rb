# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::RegistrationService do
  it 'create user successfully' do
    params = FactoryBot.attributes_for(:user)

    result = User::RegistrationService.new(params).process

    expect(result[:result]).to eq true
    expect(result[:errors]).to eq({})
    expect(result[:user].email).to eq params[:email]
  end

  it 'not equal passwords' do
    result = User::RegistrationService.new(
      email: Faker::Internet.email,
      password: '1234567890',
      password_confirmation: '123456789',
    ).process

    expect(result[:result]).to eq false
    expect(result[:errors][:detail]).to include 'password and password confirmation must be equal'
  end
end
