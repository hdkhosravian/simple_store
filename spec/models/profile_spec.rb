# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  description  :text
#  username   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#

RSpec.describe Profile, type: :model do
  subject(:profile) { create(:profile) }

  context 'validations' do
    it { expect(profile).to validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
  end

  context 'relations' do
    it { expect(profile).to belong_to(:user) }
    it { expect(profile).to have_one(:avatar).dependent(:destroy).class_name('Attachment') }
  end
end
