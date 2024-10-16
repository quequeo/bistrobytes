FactoryBot.define do
  factory :menu_item do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    price { Faker::Commerce.price(range: 0..100.0) }
    association :menu
  end
end