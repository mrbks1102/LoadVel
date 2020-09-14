FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "name" }
    sequence(:email) { |n| "test#{n}@example.com" }
    body { "body" }
  end
end
