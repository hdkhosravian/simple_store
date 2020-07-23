# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::OptionsController, type: :request do
  describe '#update' do
    context 'valid requests' do
      it 'updates all options' do
        # Require data
        user   = create(:user)
        option = create(:option, user: user)

        attributes = {
          option: FactoryBot.attributes_for(:option_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/options/#{option.id}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eql(202)
        expect(json['data']['attributes']['description']).to eql(attributes[:option][:description])
      end
    end

    context 'invalid request' do
      it 'unauthenticated request' do
        # Require data
        user   = create(:user)
        option = create(:option, user: user)

        attributes = {
          option: FactoryBot.attributes_for(:option_params),
        }

        # Request
        put "/api/v1/options/#{option.id}",
            params: attributes

        # Expects
        expect(response.status).to eql(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end

      it 'unauthorized access' do
        # Require data
        user   = create(:user)
        option = create(:option)

        attributes = {
          option: FactoryBot.attributes_for(:option_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/options/#{option.id}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eql(403)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._403'))
      end

      it 'option not found' do
        # Require data
        user   = create(:user)
        option = create(:option, user: user)

        attributes = {
          option: FactoryBot.attributes_for(:option_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/options/#{option.id + 1}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(json['errors'][0]['detail']).to eql("Couldn't find Option")
      end
    end
  end
end
