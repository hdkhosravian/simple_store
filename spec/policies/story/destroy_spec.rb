# frozen_string_literal: true

describe StoryPolicy do
  subject { described_class }

  permissions :destroy? do
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
      story = create(:story, user_id: user.id)

      # Expectations
      expect(subject).to permit(user, story)
    end
  end
end
