# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::StoriesController, type: :request do
  describe '#update' do
    context 'valid requests' do
      it 'updates all stories' do
        # Require data
        user   = create(:user)
        story = create(:story, user: user)

        attributes = {
          story: FactoryBot.attributes_for(:story_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/stories/#{story.id}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eql(202)
        expect(json['data']['attributes']['body']).to eql(attributes[:story][:body])
      end
    end

    context 'invalid request' do
      it 'unauthenticated request' do
        # Require data
        user   = create(:user)
        story = create(:story, user: user)

        attributes = {
          story: FactoryBot.attributes_for(:story_params),
        }

        # Request
        put "/api/v1/stories/#{story.id}",
            params: attributes

        # Expects
        expect(response.status).to eql(401)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._401'))
      end

      it 'unauthorized access' do
        # Require data
        user   = create(:user)
        story = create(:story)

        attributes = {
          story: FactoryBot.attributes_for(:story_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/stories/#{story.id}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eql(403)
        expect(json['errors'][0]['detail']).to eql(I18n.t('messages.http._403'))
      end

      it 'story not found' do
        # Require data
        user   = create(:user)
        story = create(:story, user: user)

        attributes = {
          story: FactoryBot.attributes_for(:story_params),
        }

        # Request
        sign_in(user)
        put "/api/v1/stories/#{story.id + 1}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(json['errors'][0]['detail']).to eql("Couldn't find Story")
      end

      it 'invalid story type' do
        # Require data
        user       = create(:user)
        story     = create(:story, user: user)

        attributes = {
          story: FactoryBot.attributes_for(:story_params, image: fixture_file_upload('test.mp4', 'story/mp4')),
        }

        # Request
        sign_in(user)
        put "/api/v1/stories/#{story.id}",
            headers: auth_header,
            params: attributes

        # Expects
        expect(response.status).to eql(406)
        expect(json['errors'][0]['detail']).to eql(I18n.t('api.v1.stories.errors.format'))
      end
    end
  end
end
