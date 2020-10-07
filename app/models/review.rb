class Review < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :notifications, dependent: :destroy
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 300 }
end
