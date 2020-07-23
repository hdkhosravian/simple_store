# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::V1::VariationsController, type: :routing do
  it 'GET api_v1_variations' do
    expect(get: '/api/v1/products/1/variations').to route_to(controller: 'api/v1/variations', action: 'index', product_id: '1')
  end

  it 'GET api_v1_variations' do
    expect(get: '/api/v1/products/1/variations/1').to route_to(controller: 'api/v1/variations', action: 'show', product_id: '1', id: '1')
  end

  it 'POST api_v1_variations' do
    expect(post: '/api/v1/products/1/variations').to route_to(controller: 'api/v1/variations', action: 'create', product_id: '1')
  end

  it 'PUT api_v1_variations' do
    expect(put: '/api/v1/products/1/variations/1').to route_to(controller: 'api/v1/variations', action: 'update', product_id: '1', id: '1')
  end

  it 'DELETE api_v1_variations' do
    expect(delete: '/api/v1/products/1/variations/1').to route_to(controller: 'api/v1/variations', action: 'destroy', product_id: '1', id: '1')
  end
end
