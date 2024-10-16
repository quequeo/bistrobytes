FactoryBot.define do
  factory :menu do
    name { Faker::Restaurant.name }
    description { Faker::Restaurant.description }
  end
end