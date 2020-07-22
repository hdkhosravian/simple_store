# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::ChangePasswordService do
  it 'changes password successfully' do
    params = FactoryBot.attributes_for(:change_password)
    user   = create(:user)

    result = User::ChangePasswordService.new(params, user).process

    expect(result[:result]).to eq true
    expect(result[:errors]).to eq({})
  end

  it 'not equal passwords' do
    user = create(:user)

    result = User::ChangePasswordService.new(
      {
        password: user.password,
        new_password: '1234567890',
        new_password_confirmation: '123456789',
      }, user
    ).process

    expect(result[:result]).to eq false
    expect(result[:errors][:detail]).to eq I18n.t('api.v1.users.change_password.not_equal_new_passwords')
  end

  it 'not correct password' do
    user = create(:user)

    result = User::ChangePasswordService.new(
      {
        password: user.password + '1',
        new_password: '1234567890',
        new_password_confirmation: '1234567890',
      }, user
    ).process

    expect(result[:result]).to eq false
    expect(result[:errors][:detail]).to eq I18n.t('api.v1.users.change_password.incorrect_password')
  end
end
