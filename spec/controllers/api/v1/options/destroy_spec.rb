# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::OptionsController, type: :request do
  describe '.destroy' do
    context 'valid requests' do
      it 'deletes options' do
        # Require data
        user   = create(:user)
        option = create(:option, user: user)

        # Request
        sign_in(user)
        delete "/api/v1/options/#{option.id}",
               headers: auth_header

        # Expects
        expect(response.status).to eql(204)
      end
    end

    context 'invalid requests' do
      it 'unauthenticated request' do
        # Require data
        user   = create(:user)
        option = create(:option, user: user)

        # Request
        delete "/api/v1/options/#{option.id}"

        # Expects
        expect(response.status).to eql(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end

      it 'unauthorized access' do
        # Require data
        user   = create(:user)
        option = create(:option)

        # Request
        sign_in(user)
        delete "/api/v1/options/#{option.id}",
               headers: auth_header

        # Expects
        expect(response.status).to eql(403)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._403'))
      end

      it 'option not found' do
        # Require data
        user   = create(:user)
        option = create(:option, user: user)

        # Request
        sign_in(user)
        delete "/api/v1/options/#{option.id + 1}",
               headers: auth_header

        # Expects
        expect(json['errors'][0]['detail']).to eql("Couldn't find Option")
      end
    end
  end
end
