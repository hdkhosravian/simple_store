# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::StoriesController, type: :request do
  describe '.destroy' do
    context 'valid requests' do
      it 'deletes stories' do
        # Require data
        user   = create(:user)
        story = create(:story, user: user)

        # Request
        sign_in(user)
        delete "/api/v1/stories/#{story.id}",
               headers: auth_header

        # Expects
        expect(response.status).to eql(204)
      end
    end

    context 'invalid requests' do
      it 'unauthenticated request' do
        # Require data
        user   = create(:user)
        story = create(:story, user: user)

        # Request
        delete "/api/v1/stories/#{story.id}"

        # Expects
        expect(response.status).to eql(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end

      it 'unauthorized access' do
        # Require data
        user   = create(:user)
        story = create(:story)

        # Request
        sign_in(user)
        delete "/api/v1/stories/#{story.id}",
               headers: auth_header

        # Expects
        expect(response.status).to eql(403)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._403'))
      end

      it 'story not found' do
        # Require data
        user   = create(:user)
        story = create(:story, user: user)

        # Request
        sign_in(user)
        delete "/api/v1/stories/#{story.id + 1}",
               headers: auth_header

        # Expects
        expect(json['errors'][0]['detail']).to eql("Couldn't find Story")
      end
    end
  end
end
