# frozen_string_literal: true

describe ProductPolicy do
  subject { described_class }

  permissions :destroy? do
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
      product = create(:product, user_id: user.id)

      # Expectations
      expect(subject).to permit(user, product)
    end
  end
end
