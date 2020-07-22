# frozen_string_literal: true

RSpec.describe 'UsersController', type: :request do
  describe '#chane_password' do
    context 'valid requests' do
      it 'update password' do
        # Require data
        user = create(:user)

        attributes = FactoryBot.attributes_for(:change_password)

        # Request
        sign_in(user)
        put '/api/v1/users/change_password',
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eq(202)
        expect(json['detail']).to eq(I18n.t('api.v1.users.change_password.success'))
      end
    end

    context 'invalid request' do
      it 'unauthorized access' do
        # Require data
        attributes = FactoryBot.attributes_for(:change_password)

        # Request
        put '/api/v1/users/change_password',
            params: attributes

        # Expects
        expect(response.status).to eq(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end

      it 'wrong password' do
        # Require data
        user = create(:user)

        attributes = { password: '654321',
                       new_password: '1234567890',
                       new_password_confirmation: '1234567890' }

        # Request
        sign_in(user)
        put '/api/v1/users/change_password',
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eq(400)
        expect(json['errors'][0]['detail']).to eq(I18n.t('api.v1.users.change_password.incorrect_password'))
      end

      it 'not equal new passwords' do
        # Require data
        user = create(:user)

        attributes = { password: '123456aA',
                       new_password: '1234567890',
                       new_password_confirmation: '2134567890' }

        # Request
        sign_in(user)
        put '/api/v1/users/change_password',
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eq(400)
        expect(json['errors'][0]['detail']).to eq(I18n.t('api.v1.users.change_password.not_equal_new_passwords'))
      end
    end
  end
end
