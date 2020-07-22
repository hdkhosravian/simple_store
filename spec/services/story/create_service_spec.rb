# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story::CreateService do
  context 'valid call' do
    it 'creates successfully' do
      # Required data
      user = create(:user)
      params = FactoryBot.attributes_for(:story_params)

      # Services
      result = Story::CreateService.new(user, params).process

      # Expects
      expect(result[:object].body).to eql(params[:body])
      expect(result[:object].latitude).to eql(params[:latitude])
      expect(result[:object].longitude).to eql(params[:longitude])
      expect(result[:object].image.fileable_type).to eq('Story')
      expect(result[:object].image.file.to_s).to include('test.jpg')
    end
  end

  context 'invalid call' do
    it 'invalid story type' do
      # Required data
      user = create(:user)
      params = FactoryBot.attributes_for(:story_params, image: fixture_file_upload('test.mp4'))

      # Services
      result = Story::CreateService.new(user, params).process

      # Expects
      expect(result[:errors]).to eq(I18n.t('api.v1.stories.errors.format'))
    end
  end

  context 'invalid call' do
    it 'Blank attributes' do
      # Required data
      user = create(:user)
      params = FactoryBot.attributes_for(:story_params, body: '')

      # Services
      result = Story::CreateService.new(user, params).process

      # Expects
      expect(result[:errors][:body][0]).to eq("can't be blank")
    end
  end
end
