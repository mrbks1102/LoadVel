FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    profile_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/image/main_top.jpg")) }
  end
end
