# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product::CreateService do
  context 'valid call' do
    it 'creates successfully' do
      # Required data
      user = create(:user)
      params = FactoryBot.attributes_for(:product_params)

      # Services
      result = Product::CreateService.new(user, params).process

      # Expects
      expect(result[:object].title).to eql(params[:title])
      expect(result[:object].description).to eql(params[:description])
      expect(result[:object].sku).to eql(params[:sku])
      expect(result[:object].image.fileable_type).to eq('Product')
      expect(result[:object].image.file.to_s).to include('test.jpg')
    end
  end

  context 'invalid call' do
    it 'invalid product type' do
      # Required data
      user = create(:user)
      params = FactoryBot.attributes_for(:product_params, image: fixture_file_upload('test.mp4'))

      # Services
      result = Product::CreateService.new(user, params).process

      # Expects
      expect(result[:errors]).to eq(I18n.t('api.v1.attachments.errors.format'))
    end
  end

  context 'invalid call' do
    it 'Blank attributes' do
      # Required data
      user = create(:user)
      params = FactoryBot.attributes_for(:product_params, title: '')

      # Services
      result = Product::CreateService.new(user, params).process

      # Expects
      expect(result[:errors][:title][0]).to eq("can't be blank")
    end
  end
end
