# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::ForgotPasswordsController, type: :request do
  describe 'confirmation' do
    it 'email and password' do
      # Require data
      user = create(:taken_email)

      # Request
      post api_v1_users_forgot_passwords_url, params: { email: user.email }

      # Expects
      r = JSON.parse(response.body)
      expect(r).not_to be nil
      expect(response.code).to eq '200'
    end

    context 'invalid' do
      it 'email' do
        # Request
        post api_v1_users_forgot_passwords_url, params: { email: Faker::Internet.email }

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
        post api_v1_users_forgot_passwords_url

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'Parameter email is required'
        expect(response.code).to eq '400'
      end
    end
  end
end
