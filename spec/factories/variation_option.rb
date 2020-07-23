FactoryBot.define do
  factory :variation_option do
    option { |a| a.association(:option) }
    product { |a| a.association(:product) }
  end
end
