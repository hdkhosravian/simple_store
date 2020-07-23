# frozen_string_literal: true

RSpec.describe Api::V1::VariationsController, type: :request do
  describe '#index' do
    it 'shows list of variations', :dox do
      # Require data
      user    = create(:user)
      product    = create(:product)
      variations = create_list(:variation, 3, product: product)

      # Request
      sign_in(user)

      # Request
      sign_in(user)
      get "/api/v1/products/#{product.id}/variations",
           headers: auth_header

      # Expects
      expect(response.status).to eq(200)
      expect(json['data'][0]['attributes']['price']).to eq(variations[0].price)
      expect(json['data'][1]['attributes']['price']).to eq(variations[1].price)
      expect(json['data'][2]['attributes']['price']).to eq(variations[2].price)
    end

    context 'invalid request' do
      it 'unauthorized access', :dox do
        # Require data
        user    = create(:user)
        product    = create(:product)
        variations = create_list(:variation, 3, product: product)

        # Request
        get "/api/v1/products/#{product.id}/variations"

        # Expects
        expect(response.status).to eq(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end
    end
  end
end