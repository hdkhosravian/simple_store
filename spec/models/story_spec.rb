require 'rails_helper'

RSpec.describe Story, type: :model do
  subject(:story) { create(:story) }

  context 'validations' do
    it { expect(story).to validate_presence_of(:body) }
    it { expect(story).to validate_presence_of(:latitude) }
    it { expect(story).to validate_presence_of(:longitude) }
  end

  context 'relations' do
    it { expect(story).to belong_to(:user) }
    it { expect(story).to have_one(:image) }
  end
end
