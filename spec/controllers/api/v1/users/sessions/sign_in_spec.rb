# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :request do
  describe 'sign_in' do
    it 'email and password' do
      # Require data
      create(:taken_email)

      # Request
      post api_v1_users_sessions_url, params: FactoryBot.attributes_for(:taken_email)

      # Expects
      r = JSON.parse(response.body)
      expect(r).not_to be nil
      expect(response.code).to eq '200'
      expect(r['included'][0]['attributes']['token']).to eq User.last.token.token
    end

    context 'invalid' do
      it 'email' do
        # Request
        post api_v1_users_sessions_url, params: FactoryBot.attributes_for(:user)

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'the email address or password is not correct'
        expect(response.code).to eq '400'
      end

      it 'password' do
        # Request
        post api_v1_users_sessions_url, params: FactoryBot.attributes_for(:user)

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'the email address or password is not correct'
        expect(response.code).to eq '400'
      end
    end

    context 'blank' do
      it 'email' do
        # Request
        post api_v1_users_sessions_url, params: FactoryBot.attributes_for(:email_balnk)

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'Parameter email is required'
        expect(response.code).to eq '400'
      end

      it 'password' do
        # Request
        post api_v1_users_sessions_url, params: FactoryBot.attributes_for(:password_blank)

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'Parameter password is required'
        expect(response.code).to eq '400'
      end
    end
  end
end
