require 'rails_helper'

RSpec.describe Option, type: :model do
  subject(:option) { create(:option) }

  context 'validations' do
    it { expect(option).to validate_presence_of(:title) }
    it { expect(option).to validate_presence_of(:description) }
  end

  context 'relations' do
    it { expect(option).to belong_to(:user) }
  end
end
