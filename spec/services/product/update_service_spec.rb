# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product::UpdateService do
  context 'valid call' do
    it 'Updates successfully' do
      # Required data
      product  = create(:product)
      params = FactoryBot.attributes_for(:product_params)

      # Services
      Product::UpdateService.new(product, params).process

      # Expects
      expect(product.title).to eql(params[:title])
      expect(product.description).to eql(params[:description])
      expect(product.sku).to eql(params[:sku])
      expect(product.image.fileable_type).to eq('Product')
      expect(product.image.fileable_id).to eq(product.id)
      expect(product.image.file.to_s).to include('test.jpg')
    end
  end
end
