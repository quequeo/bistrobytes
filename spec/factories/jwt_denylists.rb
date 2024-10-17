FactoryBot.define do
  factory :jwt_denylist do
    jti { "MyString" }
    exp { "2024-10-16 22:47:41" }
  end
end
