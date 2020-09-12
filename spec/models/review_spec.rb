require "rails_helper"

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:review_post) { create(:post, user: user) }
  let(:review) { create(:review, user: user, post: review_post) }

  describe "create" do
    context "値が正常に渡されている場合" do
      example "正常に投稿されること" do
        expect(review).to be_valid
      end
    end
  end

  describe "バリデーション" do
    context "titleが空の場合" do
      example "登録に失敗する" do
        review.title = ""
        review.valid?
        expect(review.errors[:title]).to include("を入力してください")
      end
    end

    context "titleが50文字より多いの場合" do
      example "登録に失敗する" do
        review.title = "a" * 51
        review.valid?
        expect(review.errors[:title]).to include("は50文字以内で入力してください")
      end
    end

    context "titleが50文字以下の場合" do
      example "登録に成功する" do
        review.title = "a" * 50
        review.valid?
        expect(review).to be_valid
      end
    end

    context "bodyが空の場合" do
      example "登録に失敗する" do
        review.body = ""
        review.valid?
        expect(review.errors[:body]).to include("を入力してください")
      end
    end

    context "bodyが300文字より多いの場合" do
      example "登録に失敗する" do
        review.body = "a" * 301
        review.valid?
        expect(review.errors[:body]).to include("は300文字以内で入力してください")
      end
    end

    context "bodyが300文字以下の場合" do
      example "登録に成功する" do
        review.body = "a" * 300
        review.valid?
        expect(review).to be_valid
      end
    end
  end
end
