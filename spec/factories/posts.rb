FactoryBot.define do
  factory :post do
    area { 'area' }
    post_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/image/main_top.jpg')) }
  end
end
