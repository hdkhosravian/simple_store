# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AttachmentsController, type: :routing do
  it 'GET api_v1_profiles' do
    expect(get: '/api/v1/attachments/1')
      .to route_to(controller: 'api/v1/attachments', action: 'show', id: '1')
  end
end
