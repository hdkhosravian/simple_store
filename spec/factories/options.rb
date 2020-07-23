FactoryBot.define do
  factory :option do
    title  { Option.titles.keys.sample }
    description { Faker::Lorem.paragraph }

    user { |a| a.association(:user) }
  end

  factory :option_params, class: Option do
    title  { Option.titles.keys.sample }
    description { Faker::Lorem.paragraph }
  end
end
