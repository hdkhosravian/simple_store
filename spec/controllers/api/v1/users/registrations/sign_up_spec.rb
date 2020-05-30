# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::RegistrationsController, type: :request do
  describe 'sign_up' do
    it 'email and password' do
      # Request
      post api_v1_users_registrations_url, params: FactoryBot.attributes_for(:user)

      # Expects
      r = JSON.parse(response.body)
      expect(r).not_to be nil
      expect(response.code).to eq '201'
    end

    it 'email is taken' do
      # Request
      create(:taken_email)
      post api_v1_users_registrations_url, params: FactoryBot.attributes_for(:taken_email)

      # Expects
      r = JSON.parse(response.body)
      expect(r).not_to be nil
      expect(r['errors'][0]['detail']['email'][0]).to include 'has already been taken'
      expect(response.code).to eq '400'
    end

    context 'invalid' do
      it 'email' do
        # Request
        post api_v1_users_registrations_url, params: FactoryBot.attributes_for(:email_invalid)

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']['email'][0]).to include 'is invalid'
        expect(response.code).to eq '400'
      end

      it 'password' do
        # Request
        post api_v1_users_registrations_url, params: FactoryBot.attributes_for(:password_invalid)

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']['password'][0]).to include 'short'
        expect(response.code).to eq '400'
      end

      it 'password is not equal with password_confirmation' do
        # Request
        post api_v1_users_registrations_url, params: FactoryBot.attributes_for(:not_equal_passwords)

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'must be equal'
        expect(response.code).to eq '400'
      end
    end

    context 'blank' do
      it 'email' do
        # Request
        post api_v1_users_registrations_url, params: FactoryBot.attributes_for(:email_balnk)

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'Parameter email is required'
        expect(response.code).to eq '400'
      end

      it 'password' do
        # Request
        post api_v1_users_registrations_url, params: FactoryBot.attributes_for(:password_blank)

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'Parameter password is required'
        expect(response.code).to eq '400'
      end

      it 'password_confirmation' do
        # Request
        post api_v1_users_registrations_url, params: FactoryBot.attributes_for(:password_confirmation_blank)

        # Expects
        r = JSON.parse(response.body)
        expect(r).not_to be nil
        expect(r['errors'][0]['detail']).to include 'Parameter password_confirmation is required'
        expect(response.code).to eq '400'
      end
    end
  end
end
