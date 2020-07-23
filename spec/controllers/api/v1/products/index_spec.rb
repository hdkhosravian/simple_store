# frozen_string_literal: true

RSpec.describe Api::V1::ProductsController, type: :request do
  describe '#index' do
    it 'shows list of products', :dox do
      # Require data
      user    = create(:user)
      products = create_list(:product, 3)

      # Request
      sign_in(user)

      # Request
      sign_in(user)
      get "/api/v1/products",
           headers: auth_header

      # Expects
      expect(response.status).to eq(200)
      expect(json['data'][0]['attributes']['title']).to eq(products[0].title)
      expect(json['data'][1]['attributes']['title']).to eq(products[1].title)
      expect(json['data'][2]['attributes']['title']).to eq(products[2].title)
    end

    context 'invalid request' do
      it 'unauthorized access', :dox do
        # Request
        get '/api/v1/products'

        # Expects
        expect(response.status).to eq(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end
    end
  end
end