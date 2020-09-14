require "rails_helper"

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }

  let(:favorite_post) { create(:post, user: user) }
  let(:favorite) { create(:favorite, user: user, post: favorite_post) }

  describe "create" do
    context "値が正常に渡された場合" do
      example "正常にいいねされること" do
        expect(favorite).to be_valid
      end
    end

    context "user_idが空の場合" do
      example "失敗すること" do
        favorite.user_id = nil
        favorite.valid?
        expect(favorite).to be_invalid
      end
    end

    context "post_idが空の場合" do
      example "失敗すること" do
        favorite.post_id = nil
        favorite.valid?
        expect(favorite).to be_invalid
      end
    end

    context "既お気に入りされている場合" do
      example "お気に入りできない" do
        favorite
        other_favorite = build(:favorite, user_id: favorite.user_id, post_id: favorite.post_id)
        expect(other_favorite).to be_invalid
      end
    end
  end
end
