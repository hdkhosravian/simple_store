# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::V1::ProductsController, type: :routing do
  it 'GET api_v1_products' do
    expect(get: '/api/v1/products').to route_to(controller: 'api/v1/products', action: 'index')
  end

  it 'GET api_v1_products' do
    expect(get: '/api/v1/products/1').to route_to(controller: 'api/v1/products', action: 'show', id: '1')
  end

  it 'POST api_v1_products' do
    expect(post: '/api/v1/products').to route_to(controller: 'api/v1/products', action: 'create')
  end

  it 'PUT api_v1_products' do
    expect(put: '/api/v1/products/1').to route_to(controller: 'api/v1/products', action: 'update', id: '1')
  end

  it 'DELETE api_v1_products' do
    expect(delete: '/api/v1/products/1').to route_to(controller: 'api/v1/products', action: 'destroy', id: '1')
  end
end
