FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    introduction { Faker::Lorem.sentence }
    category_id { Faker::Number.within(range: 1..10) }
    condition_id { Faker::Number.within(range: 1..6) }
    postage_payer_id { Faker::Number.within(range: 1..2) }
    prefecture_id { Faker::Number.within(range: 1..47) }
    shipping_time_id { Faker::Number.within(range: 1..3) }
    price { Faker::Number.within(range: 300..9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpeg'), filename: 'test_image.jpeg')
    end
  end
end