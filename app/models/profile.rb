# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  description  :text
#  username :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#

class Profile < ApplicationRecord
  belongs_to :user
  has_one :avatar, as: :fileable, class_name: 'Attachment', dependent: :destroy

  validates :username, presence: true, uniqueness: true

  # enum accessibility: [:personal, :shop]
end
