require "rails_helper"

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }

  let(:like_post) { create(:post, user: user) }
  let(:like) { create(:like, user: user, post: like_post) }

  describe "create" do
    context "値が正常に渡された場合" do
      example "正常にいいねされること" do
        expect(like).to be_valid
      end
    end

    context "user_idが空の場合" do
      example "失敗すること" do
        like.user_id = nil
        like.valid?
        expect(like).to be_invalid
      end
    end

    context "post_idが空の場合" do
      example "失敗すること" do
        like.post_id = nil
        like.valid?
        expect(like).to be_invalid
      end
    end

    context "既お気に入りされている場合" do
      it "お気に入りできない" do
        like
        other_like = build(:like, user_id: like.user_id, post_id: like.post_id)
        expect(other_like).to be_invalid
      end
    end
  end
end
