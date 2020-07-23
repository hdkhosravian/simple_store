# frozen_string_literal: true

describe ProductPolicy do
  subject { described_class }

  permissions :index? do
    it 'grants access to all' do
      # Expectations
      expect(subject).to permit(create(:user), create_list(:product, 10))
    end
  end
end
