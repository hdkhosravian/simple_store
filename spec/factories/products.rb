FactoryBot.define do
  factory :product do
    title  { Faker::Vehicle.manufacture }
    description { Faker::Lorem.paragraph }
    sku { Faker::Number.number(digits: 2) }

    user { |a| a.association(:user) }
    image { |a| a.association(:attachment) }
  end

  factory :product_params, class: Product do
    title  { Faker::Vehicle.manufacture }
    description { Faker::Lorem.paragraph }
    sku { Faker::Number.number(digits: 2) }

    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg')) }
  end
end
