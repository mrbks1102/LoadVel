FactoryBot.define do
  factory :post do
    area { "area" }
    street_address { "street_address" }
    time { "17:00~" }
    regular_holiday { "月曜日" }
    url { "http://localhost:3000/" }
    shop_name { "shop_name" }
    station { "station" }
    post_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/image/main_top.jpg")) }
    association :user
  end
end
