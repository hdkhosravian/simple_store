# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story::ValidateImageTypeService do
  context 'valid file' do
    it 'correct file type' do
      # Required data
      params = fixture_file_upload('test.jpg')

      # Services
      result = Story::ValidateImageTypeService.new(params).process

      # Expects
      expect(result[:errors]).to eq(nil)
    end
  end

  context 'invalid file' do
    it 'incorrect file type' do
      # Required data
      params = fixture_file_upload('test.mp4')

      # Services
      result = Story::ValidateImageTypeService.new(params).process

      # Expects
      expect(result[:errors]).to eq(I18n.t('api.v1.stories.errors.format'))
    end
  end
end
