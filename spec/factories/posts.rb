FactoryBot.define do
  factory :post do
    user { create(:user) }
    area { 'area' }
    post_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/image/main_top.jpg')) }
  end
end
