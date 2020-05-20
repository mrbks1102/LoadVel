class Post < ApplicationRecord
  belongs_to :user
  validates :post_photo, presence: true
end
