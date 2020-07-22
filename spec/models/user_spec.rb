# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  context 'associations' do
    it { expect(user).to have_many(:auth_tokens) }
    it { expect(user).to have_one(:profile).dependent(:destroy) }
  end

  describe 'methods' do
    context 'token' do
      it 'returns the last token' do
        # Require data
        user   = create(:user)
        tokens = create_list(:auth_token, 2, tokenable: user)

        # Expects
        expect(user.token).to eql(tokens.last)
      end
    end
  end
end
