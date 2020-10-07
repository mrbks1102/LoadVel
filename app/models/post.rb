class Post < ApplicationRecord
  VALID_URL_REGEX = /\A#{URI.regexp(%w(http https))}\z/.freeze
  Noon = 2
  Cafe = 3

  has_many :post_category_relations, dependent: :destroy
  has_many :categories, through: :post_category_relations
  has_many :reviews, dependent: :destroy
  has_many :favorites, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :user
  validates :user_id, presence: true
  validates :post_photo, presence: true
  validates :area, presence: true, length: { maximum: 30 }
  validates :street_address, length: { maximum: 50 }
  validates :time, length: { maximum: 30 }
  validates :regular_holiday, length: { maximum: 30 }
  validates :url, length: { maximum: 50 }, format: { with: VALID_URL_REGEX }, allow_blank: true
  validates :station, length: { maximum: 20 }
  validates :shop_name, length: { maximum: 20 }
  mount_uploader :post_photo, ImageUploader
  geocoded_by :street_address
  after_validation :geocode

  scope :likes_posts, -> do
    includes(:likes).where(id: Like.group(:post_id).order(Arel.sql("count(post_id) desc")).pluck(:post_id))
  end

  scope :noon_posts, -> do
    includes(:categories).limit(4).where(post_category_relations: { category_id: Noon })
  end

  scope :rider_cafe_posts, -> do
    includes(:categories).limit(4).where(post_category_relations: { category_id: Cafe })
  end

  scope :none_posts, -> { where.not(id: @post.id) }

  def self.csv_attributes
    ["area", "street_address", "place_name", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |post|
        csv << csv_attributes.map { |attr| post.send(attr) }
      end
    end
  end

  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )

      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_review!(current_user, review_id)
    temp_ids = Review.where(post_id: id).where.not("user_id=? or user_id=?", current_user.id, user_id).select(:user_id).distinct
    temp_ids.each do |temp_id|
      save_notification_review!(current_user, review_id, temp_id['user_id'])
    end
    save_notification_review!(current_user, review_id, user_id)
  end

  def save_notification_review!(current_user, review_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      review_id: review_id,
      visited_id: visited_id,
      action: 'review'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  enum place_name: {
    "---": 0,
    北海道: 1,
    青森県: 2,
    岩手県: 3,
    宮城県: 4,
    秋田県: 5,
    山形県: 6,
    福島県: 7,
    茨城県: 8,
    栃木県: 9,
    群馬県: 10,
    埼玉県: 11,
    千葉県: 12,
    東京都: 13,
    神奈川県: 14,
    新潟県: 15,
    富山県: 16,
    石川県: 17,
    福井県: 18,
    山梨県: 19,
    長野県: 20,
    岐阜県: 21,
    静岡県: 22,
    愛知県: 23,
    三重県: 24,
    滋賀県: 25,
    京都府: 26,
    大阪府: 27,
    兵庫県: 28,
    奈良県: 29,
    和歌山県: 30,
    鳥取県: 31,
    島根県: 32,
    岡山県: 33,
    広島県: 34,
    山口県: 35,
    徳島県: 36,
    香川県: 37,
    愛媛県: 38,
    高知県: 39,
    福岡県: 40,
    佐賀県: 41,
    長崎県: 42,
    熊本県: 43,
    大分県: 44,
    宮崎県: 45,
    鹿児島県: 46,
    沖縄県: 47,
  }

  def favorited_by(user)
    Favorite.find_by(user_id: user.id, post_id: id)
  end

  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id)
  end
end
