# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::VariationsController, type: :request do
  describe '.show' do
    context 'valid requests' do
      it 'gets products' do
        # Require data
        user             = create(:user)
        product          = create(:product, user: user)
        variation        = create(:variation, product: product)

        # Request
        sign_in(user)
        get "/api/v1/products/#{product.id}/variations/#{variation.id}",
            headers: auth_header

        # Expects
        expect(json['data']['attributes']['price']).to eql(variation.price)
        expect(json['data']['attributes']['quantity']).to eql(variation.quantity)
        expect(json['data']['attributes']['sku']).to eql(variation.sku)
      end
    end

    context 'invalid requests' do
      it 'unauthenticated request' do
        # Require data
        user             = create(:user)
        product          = create(:product, user: user)
        variation        = create(:variation, product: product)

        # Request
        get "/api/v1/products/#{product.id}/variations/#{variation.id}"

        # Expects
        expect(response.status).to eql(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end

      it 'Variation not found' do
        # Require data
        user             = create(:user)
        product          = create(:product, user: user)
        variation        = create(:variation, product: product)

        # Request
        sign_in(user)
        get "/api/v1/products/#{product.id}/variations/#{variation.id + 1}",
            headers: auth_header

        # Expects
        expect(json['errors'][0]['detail']).to eql("Couldn't find Variation")
      end
    end
  end
end
