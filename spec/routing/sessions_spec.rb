# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :routing do
  it 'Post sign_in' do
    expect(post: 'api/v1/users/sessions').to route_to(controller: 'api/v1/users/sessions', action: 'create')
  end

  it 'Put refresh_token' do
    expect(put: 'api/v1/users/sessions').to route_to(controller: 'api/v1/users/sessions', action: 'update')
  end

  it 'delete sign_out' do
    expect(delete: 'api/v1/users/sessions').to route_to(controller: 'api/v1/users/sessions', action: 'destroy')
  end
end
