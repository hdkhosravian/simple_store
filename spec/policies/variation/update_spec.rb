# frozen_string_literal: true

describe VariationPolicy do
  subject { described_class }

  permissions :update? do
    it 'denies access' do
      # Required data
      product = create(:product)
      variation = create(:variation)

      # Expectations
      expect(subject).not_to permit(product.user, variation)
    end

    it 'grants access' do
      # Required data
      user     = create(:user)
      product = create(:product, user: user)
      variation = create(:variation, product: product)

      # Expectations
      expect(subject).to permit(user, variation)
    end
  end
end
