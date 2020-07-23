# frozen_string_literal: true

describe VariationPolicy do
  subject { described_class }

  permissions :create? do
    it 'grants access to all' do
      # Expectations
      expect(subject).to permit(create(:user))
    end
  end
end
