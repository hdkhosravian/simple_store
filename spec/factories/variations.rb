FactoryBot.define do
  factory :variation do
    price { Faker::Number.number(digits: 2).to_s }
    quantity { Faker::Number.number(digits: 2) }
    sku { Faker::Number.number(digits: 2) }

    product { |a| a.association(:product) }
    image { |a| a.association(:attachment) }
  end

  factory :variation_params, class: Product do
    price { Faker::Number.number(digits: 2).to_s }
    quantity { Faker::Number.number(digits: 2) }
    sku { Faker::Number.number(digits: 2) }

    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg')) }
  end
end
