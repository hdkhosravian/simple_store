# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::VariationsController, type: :request do
  describe '#update' do
    context 'valid requests' do
      it 'updates all products' do
        # Require data
        user   = create(:user)
        product = create(:product, user: user)
        variation = create(:variation, product: product)

        attributes = {
          variation: FactoryBot.attributes_for(:variation_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/products/#{product.id}/variations/#{variation.id}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eql(202)
        expect(json['data']['attributes']['price']).to eql(attributes[:variation][:price])
      end
    end

    context 'invalid request' do
      it 'unauthenticated request' do
        # Require data
        user   = create(:user)
        product = create(:product, user: user)
        variation = create(:variation, product: product)

        attributes = {
          variation: FactoryBot.attributes_for(:variation_params),
        }

        # Request
        put "/api/v1/products/#{product.id}/variations/#{variation.id}",
            params: attributes

        # Expects
        expect(response.status).to eql(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end

      it 'unauthorized access' do
        # Require data
        user   = create(:user)
        product = create(:product)
        variation = create(:variation)

        attributes = {
          variation: FactoryBot.attributes_for(:variation_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/products/#{product.id}/variations/#{variation.id}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eql(403)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._403'))
      end

      it 'variation not found' do
        # Require data
        user   = create(:user)
        product = create(:product, user: user)
        variation = create(:variation, product: product)

        attributes = {
          variation: FactoryBot.attributes_for(:variation_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/products/#{product.id}/variations/#{variation.id + 1}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(json['errors'][0]['detail']).to eql("Couldn't find Variation")
      end

      it 'invalid variation type' do
        # Require data
        user       = create(:user)
        product     = create(:product, user: user)
        variation = create(:variation, product: product)

        attributes = {
          variation: FactoryBot.attributes_for(:variation_params, image: fixture_file_upload('test.mp4', 'product/mp4')),
        }

        # Request
        sign_in(user)
        put "/api/v1/products/#{product.id}/variations/#{variation.id}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eql(406)
        expect(json['errors'][0]['detail']).to eql(I18n.t('api.v1.attachments.errors.format'))
      end
    end
  end
end
