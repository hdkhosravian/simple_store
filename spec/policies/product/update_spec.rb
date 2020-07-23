# frozen_string_literal: true

describe ProductPolicy do
  subject { described_class }

  permissions :update? do
    it 'denies access' do
      # Required data
      user     = create(:user)
      product = create(:product)

      # Expectations
      expect(subject).not_to permit(user, product)
    end

    it 'grants access' do
      # Required data
      user     = create(:user)
      product = create(:product, user: user)

      # Expectations
      expect(subject).to permit(user, product)
    end
  end
end
