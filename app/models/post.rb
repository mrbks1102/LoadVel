class Post < ApplicationRecord
  belongs_to :user
  validates :post_photo, presence: true
  mount_uploader :post_photo, ImageUploader
end
