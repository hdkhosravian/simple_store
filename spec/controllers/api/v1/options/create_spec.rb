# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::OptionsController, type: :request do
  describe '.create' do
    context 'valid requests' do
      it 'creates options' do
        # Require data
        user   = create(:user)

        attributes = {
          option: FactoryBot.attributes_for(:option_params),
        }

        # Request
        sign_in(user)
        post "/api/v1/options",
             headers: auth_header,
             params: attributes

        # Expects
        expect(response.status).to eql(201)
        expect(json['data']['attributes']['description']).to eql(attributes[:option][:description])
      end

      it 'blank attributes' do
        # Require data
        user   = create(:user)

        attributes = {
          option: FactoryBot.attributes_for(:option_params, description: nil),
        }

        # Request
        sign_in(user)
        post "/api/v1/options",
             headers: auth_header,
             params: attributes

        # Expects
        expect(response.status).to eql(422)
        expect(json['errors'][0]['detail']).to eql("Description can't be blank")
      end
    end

    context 'invalid request' do
      it 'unauthenticated request' do
        # Require data
        user   = create(:user)

        attributes = {
          option: FactoryBot.attributes_for(:option_params),
        }

        # Request
        post "/api/v1/options",
             params: attributes

        # Expects
        expect(response.status).to eql(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end
    end
  end
end
