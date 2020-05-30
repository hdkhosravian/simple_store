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

FactoryBot.define do
  factory :user do |_f|
    sequence(:email) { |n| "#{n}_#{Faker::Internet.email}" }
    password { '123456aA' }
    password_confirmation { '123456aA' }
  end

  factory :password_confirmation_blank, parent: :user do |_f|
    password_confirmation { nil }
  end

  factory :password_blank, parent: :user do |_f|
    password { nil }
  end

  factory :email_balnk, parent: :user do |_f|
    email    { nil }
  end

  factory :blank_params, parent: :user do |_f|
    email    { nil }
    password { nil }
  end

  factory :email_invalid, parent: :user do |_f|
    email    { 'test@' }
  end

  factory :not_equal_passwords, parent: :user do |_f|
    password { '123456aA' }
    password_confirmation { '123456aAa' }
  end

  factory :password_invalid, parent: :user do |_f|
    password { '123' }
    password_confirmation { '123' }
  end

  factory :taken_email, parent: :user do |_f|
    email    { 'test@test.test' }
    password { '123456aA' }
    password_confirmation { '123456aA' }
  end

  factory :change_password, class: User do |_f|
    password { '123456aA' }
    new_password { 'aA123456' }
    new_password_confirmation { 'aA123456' }

    trait :params do
      transient do
        password_confirmation { nil }
        email { nil }
      end
    end
  end
end
