# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::VariationsController, type: :request do
  describe '.create' do
    context 'valid requests' do
      it 'creates products' do
        # Require data
        user   = create(:user)
        product   = create(:product)

        attributes = {
          variation: FactoryBot.attributes_for(:variation_params),
        }

        # Request
        sign_in(user)
        post "/api/v1/products/#{product.id}/variations",
             headers: auth_header,
             params: attributes

        # Expects
        expect(response.status).to eql(201)
        expect(json['data']['attributes']['price']).to eql(attributes[:variation][:price])
      end

      it 'blank attributes' do
        # Require data
        user   = create(:user)
        product   = create(:product)

        attributes = {
          variation: FactoryBot.attributes_for(:variation_params, price: nil),
        }

        # Request
        sign_in(user)
        post "/api/v1/products/#{product.id}/variations",
             headers: auth_header,
             params: attributes

        # Expects
        expect(response.status).to eql(406)
        expect(json['errors'][0]['detail']['price'][0]).to eql("can't be blank")
      end
    end

    context 'invalid request' do
      it 'unauthenticated request' do
        # Require data
        user   = create(:user)
        product   = create(:product)

        attributes = {
          variation: FactoryBot.attributes_for(:variation_params),
        }

        # Request
        post "/api/v1/products/#{product.id}/variations",
             params: attributes

        # Expects
        expect(response.status).to eql(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end

      it 'wrong file type' do
        # Require data
        user   = create(:user)
        product   = create(:product)

        attributes = {
          variation: FactoryBot.attributes_for(:variation_params, image: fixture_file_upload('test.mp4', 'video/mp4')),
        }

        # Request
        sign_in(user)
        post "/api/v1/products/#{product.id}/variations",
             headers: auth_header,
             params: attributes

        # Expects
        expect(response.status).to eql(406)
        expect(json['errors'][0]['detail']).to eql(I18n.t('api.v1.attachments.errors.format'))
      end
    end
  end
end
