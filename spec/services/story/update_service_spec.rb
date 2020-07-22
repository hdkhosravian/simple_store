# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story::UpdateService do
  context 'valid call' do
    it 'Updates successfully' do
      # Required data
      story  = create(:story)
      params = FactoryBot.attributes_for(:story_params)

      # Services
      Story::UpdateService.new(story, params).process

      # Expects
      expect(story.body).to eql(params[:body])
      expect(story.latitude).to eql(params[:latitude])
      expect(story.longitude).to eql(params[:longitude])
      expect(story.image.fileable_type).to eq('Story')
      expect(story.image.fileable_id).to eq(story.id)
      expect(story.image.file.to_s).to include('test.jpg')
    end
  end
end
