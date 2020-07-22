# frozen_string_literal: true

describe ProfilePolicy do
  subject { described_class }

  permissions :update? do
    it 'denies access to other profiles' do
      # Required data
      user    = create(:user)
      profile = create(:profile)

      # Expectations
      expect(subject).not_to permit(user, profile)
    end

    it 'grants access to current_user profile' do
      # Required data
      user    = create(:user)
      profile = create(:profile, user: user)

      # Expectations
      expect(subject).to permit(user, profile)
    end
  end
end
