# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::V1::OptionsController, type: :routing do
  it 'GET api_v1_options' do
    expect(get: '/api/v1/options').to route_to(controller: 'api/v1/options', action: 'index')
  end

  it 'GET api_v1_options' do
    expect(get: '/api/v1/options/1').to route_to(controller: 'api/v1/options', action: 'show', id: '1')
  end

  it 'POST api_v1_options' do
    expect(post: '/api/v1/options').to route_to(controller: 'api/v1/options', action: 'create')
  end

  it 'PUT api_v1_options' do
    expect(put: '/api/v1/options/1').to route_to(controller: 'api/v1/options', action: 'update', id: '1')
  end

  it 'DELETE api_v1_options' do
    expect(delete: '/api/v1/options/1').to route_to(controller: 'api/v1/options', action: 'destroy', id: '1')
  end
end
