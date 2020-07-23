# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :request do
  describe '#update' do
    context 'valid requests' do
      it 'updates all products' do
        # Require data
        user   = create(:user)
        product = create(:product, user: user)

        attributes = {
          product: FactoryBot.attributes_for(:product_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/products/#{product.id}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eql(202)
        expect(json['data']['attributes']['title']).to eql(attributes[:product][:title])
      end
    end

    context 'invalid request' do
      it 'unauthenticated request' do
        # Require data
        user   = create(:user)
        product = create(:product, user: user)

        attributes = {
          product: FactoryBot.attributes_for(:product_params),
        }

        # Request
        put "/api/v1/products/#{product.id}",
            params: attributes

        # Expects
        expect(response.status).to eql(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end

      it 'unauthorized access' do
        # Require data
        user   = create(:user)
        product = create(:product)

        attributes = {
          product: FactoryBot.attributes_for(:product_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/products/#{product.id}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eql(403)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._403'))
      end

      it 'product not found' do
        # Require data
        user   = create(:user)
        product = create(:product, user: user)

        attributes = {
          product: FactoryBot.attributes_for(:product_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/products/#{product.id + 1}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(json['errors'][0]['detail']).to eql("Couldn't find Product")
      end

      it 'invalid product type' do
        # Require data
        user       = create(:user)
        product     = create(:product, user: user)

        attributes = {
          product: FactoryBot.attributes_for(:product_params, image: fixture_file_upload('test.mp4', 'product/mp4')),
        }

        # Request
        sign_in(user)
        put "/api/v1/products/#{product.id}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eql(406)
        expect(json['errors'][0]['detail']).to eql(I18n.t('api.v1.attachments.errors.format'))
      end
    end
  end
end
