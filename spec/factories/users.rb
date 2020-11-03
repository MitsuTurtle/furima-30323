FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 5) }
    email                 { Faker::Internet.free_email }
    password              { "#{Faker::Internet.password(min_length: 4)}1a" }
    password_confirmation { password }
    first_name            { '山田' }
    family_name           { '太郎' }
    first_name_kana       { 'ヤマダ' }
    family_name_kana      { 'タロウ' }
    birthday              { '2020-11-03' }
  end
end
