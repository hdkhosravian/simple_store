# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Variation::UpdateService do
  context 'valid call' do
    it 'Updates successfully' do
      # Required data
      variation  = create(:variation)
      params = FactoryBot.attributes_for(:variation_params)

      # Services
      Variation::UpdateService.new(variation, params).process

      # Expects
      expect(variation.price).to eql(params[:price])
      expect(variation.quantity).to eql(params[:quantity])
      expect(variation.sku).to eql(params[:sku])
      expect(variation.image.fileable_type).to eq('Variation')
      expect(variation.image.fileable_id).to eq(variation.id)
      expect(variation.image.file.to_s).to include('test.jpg')
    end
  end
end
