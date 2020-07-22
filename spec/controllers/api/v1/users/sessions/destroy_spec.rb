# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :request do
  describe '#logout' do
    context 'success response' do
      it 'should log out user' do
        # Require data
        user = create(:user)

        # Request
        sign_in(user)
        delete '/api/v1/users/sessions',
               headers: auth_header

        # Expects
        expect(json['detail']).to eq(I18n.t('api.v1.users.logout'))
      end
    end

    context 'invalid request' do
      it 'unauthorized access' do
        # Request
        delete '/api/v1/users/sessions'

        # Expects
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end
    end
  end
end
