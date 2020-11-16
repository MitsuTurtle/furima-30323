FactoryBot.define do
  factory :user_order_item do
    postal_code { '123-4567' }
    prefecture_id { 33 }
    city { '横浜市緑区' }
    house_number { '青山1-1-1' }
    building { '柳ビル203' }
    telephone { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
    association :user
    association :item
  end
end
