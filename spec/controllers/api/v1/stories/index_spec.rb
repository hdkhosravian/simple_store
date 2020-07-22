# frozen_string_literal: true

RSpec.describe Api::V1::StoriesController, type: :request do
  describe '#index' do
    it 'shows list of stories', :dox do
      # Require data
      user    = create(:user)
      stories = create_list(:story, 3)

      # Request
      sign_in(user)

      # Request
      sign_in(user)
      get "/api/v1/stories",
           headers: auth_header,
           params: FactoryBot.attributes_for(:story_index_params)


      # Expects
      expect(response.status).to eq(200)
      expect(json['data'][0]['attributes']['body']).to eq(stories[0].body)
      expect(json['data'][1]['attributes']['body']).to eq(stories[1].body)
      expect(json['data'][2]['attributes']['body']).to eq(stories[2].body)
    end

    context 'invalid request' do
      it 'unauthorized access', :dox do
        # Request
        get '/api/v1/stories'

        # Expects
        expect(response.status).to eq(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end
    end
  end
end