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

FactoryBot.define do
  factory :auth_token do
    token { Digest::MD5.hexdigest(Time.zone.now.to_s) + SecureRandom.hex }
    refresh_token { Digest::MD5.hexdigest(Time.zone.now.to_s) + SecureRandom.hex }
    token_expires_at { Time.zone.now.to_s }
    refresh_token_expires_at { Time.zone.now.to_s }

    tokenable { |a| a.association(:user) }
  end
end
