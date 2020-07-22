# frozen_string_literal: true

describe StoryPolicy do
  subject { described_class }

  permissions :show? do
    it 'grants access to all' do
      # Expectations
      expect(subject).to permit(create(:user), create(:story))
    end
  end
end
