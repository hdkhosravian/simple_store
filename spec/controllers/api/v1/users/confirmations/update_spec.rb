# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::ConfirmationsController, type: :request do
  describe 'confirmation' do
    it 'email and password' do
      # Request
      post api_v1_users_registrations_url, params: FactoryBot.attributes_for(:user)
      put api_v1_users_confirmations_url, params: { email: User.last.email }

      # Expects
      r = JSON.parse(response.body)
      expect(r).not_to be nil
      expect(response.code).to eq '200'
    end

    context 'invalid' do
      it 'email' do
        # Request
        put api_v1_users_confirmations_url, params: { email: Faker::Internet.email }

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include "Couldn't find User"
        expect(response.code).to eq '404'
      end
    end

    context 'blank' do
      it 'email' do
        # Request
        put api_v1_users_confirmations_url

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'Parameter email is required'
        expect(response.code).to eq '400'
      end
    end
  end
end
