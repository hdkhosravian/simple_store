require 'rails_helper'

RSpec.describe Variation, type: :model do
  subject(:variation) { create(:variation) }

  context 'validations' do
    it { expect(variation).to validate_presence_of(:price) }
    it { expect(variation).to validate_presence_of(:quantity) }
    it { expect(variation).to validate_presence_of(:sku) }
  end

  context 'relations' do
    it { expect(variation).to belong_to(:product) }
    it { expect(variation).to have_one(:image).dependent(:destroy).class_name('Attachment') }
  end
end
