# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  description  :text
#  first_name   :string
#  last_name    :string
#  phone_number :string
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

  context 'relations' do
    it { expect(profile).to belong_to(:user) }
    it { expect(profile).to have_one(:avatar).dependent(:destroy).class_name('Attachment') }
  end
end
