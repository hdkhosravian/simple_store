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

FactoryBot.define do
  factory :profile do
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    description { Faker::Lorem.paragraph }
    phone_number { Faker::PhoneNumber.phone_number }

    user { |a| a.association(:user) }
    avatar { |a| a.association(:attachment) }
  end

  factory :profile_params, class: Profile do
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    description { Faker::Lorem.paragraph }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
