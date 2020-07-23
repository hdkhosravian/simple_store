# frozen_string_literal: true

describe VariationPolicy do
  subject { described_class }

  permissions :index? do
    it 'grants access to all' do
      # Expectations
      expect(subject).to permit(create(:user), create_list(:variation, 10))
    end
  end
end
