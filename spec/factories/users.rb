FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
