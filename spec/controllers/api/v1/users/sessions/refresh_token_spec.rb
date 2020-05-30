# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :request do
  describe 'confirmation' do
    it 'email and password' do
      # Require data
      create(:taken_email)

      # Request
      post api_v1_users_sessions_url, params: FactoryBot.attributes_for(:taken_email)
      refresh_token = JSON.parse(response.body)['included'][0]['attributes']['refresh_token']
      put api_v1_users_sessions_url, params: { refresh_token: refresh_token }

      # Expects
      r = JSON.parse(response.body)
      expect(r).not_to be nil
      expect(response.code).to eq '200'
      expect(r['included'][0]['attributes']['token']).to eq User.last.token.token
    end

    context 'invalid' do
      it 'refresh_token' do
        # Request
        put api_v1_users_sessions_url, params: { refresh_token: '123456' }

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'refresh token is not correct.'
        expect(response.code).to eq '401'
      end
    end

    context 'blank' do
      it 'refresh_token' do
        # Request
        put api_v1_users_sessions_url

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'Parameter refresh_token is required'
        expect(response.code).to eq '400'
      end
    end
  end
end
