# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Variation::CreateService do
  context 'valid call' do
    it 'creates successfully' do
      # Required data
      product = create(:product)
      params = FactoryBot.attributes_for(:variation_params)

      # Services
      result = Variation::CreateService.new(product, params).process

      # Expects
      expect(result[:object].price).to eql(params[:price])
      expect(result[:object].quantity).to eql(params[:quantity])
      expect(result[:object].sku).to eql(params[:sku])
      expect(result[:object].image.fileable_type).to eq('Variation')
      expect(result[:object].image.file.to_s).to include('test.jpg')
    end
  end

  context 'invalid call' do
    it 'invalid variation type' do
      # Required data
      product = create(:product)
      params = FactoryBot.attributes_for(:variation_params, image: fixture_file_upload('test.mp4'))

      # Services
      result = Variation::CreateService.new(product, params).process

      # Expects
      expect(result[:errors]).to eq(I18n.t('api.v1.attachments.errors.format'))
    end
  end

  context 'invalid call' do
    it 'Blank attributes' do
      # Required data
      product = create(:product)
      params = FactoryBot.attributes_for(:variation_params, price: '')

      # Services
      result = Variation::CreateService.new(product, params).process

      # Expects
      expect(result[:errors][:price][0]).to eq("can't be blank")
    end
  end
end
