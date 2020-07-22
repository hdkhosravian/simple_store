# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProfilesController, type: :routing do
  it 'GET api_v1_profiles' do
    expect(get: '/api/v1/profiles/1').to route_to(controller: 'api/v1/profiles', action: 'show', id: '1')
  end

  it 'PUT api_v1_profiles' do
    expect(put: '/api/v1/profiles/1').to route_to(controller: 'api/v1/profiles', action: 'update', id: '1')
  end

  it 'PATCH api_v1_profiles' do
    expect(patch: '/api/v1/profiles/1').to route_to(controller: 'api/v1/profiles', action: 'update', id: '1')
  end
end
