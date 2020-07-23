# frozen_string_literal: true

RSpec.describe Api::V1::OptionsController, type: :request do
  describe '#index' do
    it 'shows list of options', :dox do
      # Require data
      user    = create(:user)
      options = create_list(:option, 3)

      # Request
      sign_in(user)

      # Request
      sign_in(user)
      get "/api/v1/options",
           headers: auth_header

      # Expects
      expect(response.status).to eq(200)
    end

    context 'invalid request' do
      it 'unauthorized access', :dox do
        # Request
        get '/api/v1/options'

        # Expects
        expect(response.status).to eq(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end
    end
  end
end