# frozen_string_literal: true

# == Schema Information
#
# Table name: auth_tokens
#
#  id                       :bigint           not null, primary key
#  refresh_token            :string
#  refresh_token_expires_at :datetime
#  token                    :string
#  token_expires_at         :datetime
#  tokenable_type           :string           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  tokenable_id             :bigint           not null
#
# Indexes
#
#  index_auth_tokens_on_refresh_token                    (refresh_token) UNIQUE
#  index_auth_tokens_on_token                            (token) UNIQUE
#  index_auth_tokens_on_tokenable_type_and_tokenable_id  (tokenable_type,tokenable_id)
#

require 'rails_helper'

RSpec.describe AuthToken, type: :model do
  subject(:auth_token) { create(:auth_token) }

  context 'associations' do
    it { expect(auth_token).to belong_to(:tokenable) }
  end

  context 'validations' do
    it { expect(auth_token).to validate_presence_of(:token) }
    it { expect(auth_token).to validate_presence_of(:refresh_token) }
    it { expect(auth_token).to validate_length_of(:token).is_at_least(20) }
    it { expect(auth_token).to validate_length_of(:refresh_token).is_at_least(20) }
    it { expect(auth_token).to validate_uniqueness_of(:token) }
    it { expect(auth_token).to validate_uniqueness_of(:refresh_token) }
  end
end
