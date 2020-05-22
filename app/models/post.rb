class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  mount_uploader :post_photo, ImageUploader
end
