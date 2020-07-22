# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::ConfirmationsController, type: :routing do
  it 'Post confirmation' do
    expect(post: 'api/v1/users/confirmations').to route_to(controller: 'api/v1/users/confirmations', action: 'create')
  end

  it 'Post resend_confirmation' do
    expect(put: 'api/v1/users/confirmations').to route_to(controller: 'api/v1/users/confirmations', action: 'update')
  end
end
