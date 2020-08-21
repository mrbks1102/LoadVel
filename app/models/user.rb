class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reviews_posts, through: :reviews, source: :post
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  mount_uploader :profile_photo, ImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, presence: true, length: { maximum: 50 }

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      name: auth.info.name,
      remote_profile_photo_url: auth.info.image,
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )
    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
