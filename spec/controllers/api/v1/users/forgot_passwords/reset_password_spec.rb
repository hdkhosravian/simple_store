# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::ForgotPasswordsController, type: :request do
  describe 'confirmation' do
    it 'email and password' do
      # Require data
      user        = create(:taken_email)
      hash, token = Devise.token_generator.generate(User, :reset_password_token)
      user.update(reset_password_token: token)

      # Request
      put api_v1_users_forgot_passwords_url, params: {
        token: hash,
        password: '123456aA',
        password_confirmation: '123456aA',
      }

      # Expects
      r = JSON.parse(response.body)
      expect(r).not_to be nil
      expect(response.code).to eq '200'
    end

    context 'invalid' do
      it 'token' do
        # Request
        put api_v1_users_forgot_passwords_url, params: {
          token: '123456',
          password: '123456aA',
          password_confirmation: '123456aA',
        }

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'invalid reset password token'
        expect(response.code).to eq '400'
      end
    end

    context 'blank' do
      it 'token' do
        # Request
        put api_v1_users_forgot_passwords_url, params: {
          password: '123456aA',
          password_confirmation: '123456aA',
        }

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'Parameter token is required'
        expect(response.code).to eq '400'
      end

      it 'password' do
        # Request
        put api_v1_users_forgot_passwords_url, params: {
          token: '123456',
          password_confirmation: '123456aA',
        }

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'Parameter password is required'
        expect(response.code).to eq '400'
      end

      it 'password_confirmation' do
        # Request
        put api_v1_users_forgot_passwords_url, params: {
          token: '123456',
          password: '123456aA',
        }

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'Parameter password_confirmation is required'
        expect(response.code).to eq '400'
      end
    end
  end
end
