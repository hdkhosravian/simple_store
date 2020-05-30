# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::ChangePasswordsController, type: :routing do
  it 'Post forgot_password' do
    expect(post: 'api/v1/users/forgot_passwords').to route_to(controller: 'api/v1/users/forgot_passwords', action: 'create')
  end

  it 'Put reset_password' do
    expect(put: 'api/v1/users/forgot_passwords').to route_to(controller: 'api/v1/users/forgot_passwords', action: 'update')
  end
end
