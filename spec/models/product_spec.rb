require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) { create(:product) }

  context 'validations' do
    it { expect(product).to validate_presence_of(:title) }
    it { expect(product).to validate_presence_of(:description) }
    it { expect(product).to validate_presence_of(:sku) }
  end

  context 'relations' do
    it { expect(product).to belong_to(:user) }
    it { expect(product).to have_one(:image).dependent(:destroy).class_name('Attachment') }
  end
end
