# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::RegistrationsController, type: :routing do
  it 'Post sign_up' do
    expect(post: 'api/v1/users/registrations').to route_to(controller: 'api/v1/users/registrations', action: 'create')
  end
end
