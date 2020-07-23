# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :request do
  describe '.show' do
    context 'valid requests' do
      it 'gets products' do
        # Require data
        user            = create(:user)
        product          = create(:product, user: user)

        # Request
        sign_in(user)
        get "/api/v1/products/#{product.id}",
            headers: auth_header

        # Expects
        expect(json['data']['attributes']['title']).to eql(product.title)
        expect(json['data']['attributes']['description']).to eql(product.description)
        expect(json['data']['attributes']['sku']).to eql(product.sku)
      end
    end

    context 'invalid requests' do
      it 'unauthenticated request' do
        # Require data
        user            = create(:user)
        product          = create(:product, user: user)

        # Request
        get "/api/v1/products/#{product.id}"

        # Expects
        expect(response.status).to eql(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end

      it 'Product not found' do
        # Require data
        user            = create(:user)
        product          = create(:product, user: user)

        # Request
        sign_in(user)
        get "/api/v1/products/#{product.id + 1}",
            headers: auth_header

        # Expects
        expect(json['errors'][0]['detail']).to eql("Couldn't find Product")
      end
    end
  end
end
