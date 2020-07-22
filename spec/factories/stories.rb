FactoryBot.define do
  factory :story do
    body { Faker::Quote.famous_last_words }
    latitude { 35.6892 }
    longitude { 51.3890 }

    user { |a| a.association(:user) }
  end

  factory :story_params, class: :Story do
    body { Faker::Quote.famous_last_words }
    latitude { 35.6892 }
    longitude { 51.3890 }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg')) }
  end

  factory :story_index_params, class: :Story do
    latitude { 35.6892 }
    longitude { 51.3890 }
    distance { 8 }
  end
end
