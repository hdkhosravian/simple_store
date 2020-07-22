# frozen_string_literal: true

describe StoryPolicy do
  subject { described_class }

  permissions :update? do
    it 'denies access' do
      # Required data
      user     = create(:user)
      story = create(:story)

      # Expectations
      expect(subject).not_to permit(user, story)
    end

    it 'grants access' do
      # Required data
      user     = create(:user)
      story = create(:story, user: user)

      # Expectations
      expect(subject).to permit(user, story)
    end
  end
end
