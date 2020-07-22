# frozen_string_literal: true

describe ProfilePolicy do
  subject { described_class }

  permissions :show? do
    it 'grants access to all peofiles' do
      # Expectations
      expect(subject).to permit(create(:user), create(:profile))
    end
  end
end
