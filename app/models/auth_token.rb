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

class AuthToken < ApplicationRecord
  belongs_to :tokenable, polymorphic: true

  validates :token, presence: true, length: { minimum: 20 }, uniqueness: true
  validates :refresh_token, presence: true, length: { minimum: 20 }, uniqueness: true
end
