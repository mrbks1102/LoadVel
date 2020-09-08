FactoryBot.define do
  factory :review do
    title { "title" }
    body { "body" }
    user
    post
  end
end
