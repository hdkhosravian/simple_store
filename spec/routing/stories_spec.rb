# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::V1::StoriesController, type: :routing do
  it 'GET api_v1_stories' do
    expect(get: '/api/v1/stories').to route_to(controller: 'api/v1/stories', action: 'index')
  end

  it 'GET api_v1_stories' do
    expect(get: '/api/v1/stories/1').to route_to(controller: 'api/v1/stories', action: 'show', id: '1')
  end

  it 'POST api_v1_stories' do
    expect(post: '/api/v1/stories').to route_to(controller: 'api/v1/stories', action: 'create')
  end

  it 'PUT api_v1_stories' do
    expect(put: '/api/v1/stories/1').to route_to(controller: 'api/v1/stories', action: 'update', id: '1')
  end

  it 'DELETE api_v1_stories' do
    expect(delete: '/api/v1/stories/1').to route_to(controller: 'api/v1/stories', action: 'destroy', id: '1')
  end
end
