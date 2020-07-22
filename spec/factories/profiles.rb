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

FactoryBot.define do
  factory :profile do
    username  { Faker::Name.first_name }
    description { Faker::Lorem.paragraph }
    # accessibility { Profile.accessibilities.keys.sample }

    user { |a| a.association(:user) }
    avatar { |a| a.association(:attachment) }
  end

  factory :profile_params, class: Profile do
    username  { Faker::Name.first_name }
    description { Faker::Lorem.paragraph }
    # accessibility { Profile.accessibilities.keys.sample }

    avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg')) }
  end
end
