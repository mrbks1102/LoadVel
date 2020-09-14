require "rails_helper"

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  let(:post) { create(:post, user: user) }

  describe "create" do
    context "値が正常に渡された場合" do
      example "正常に投稿が作成されること" do
        expect(post).to be_valid
      end
    end
  end

  describe "バリデーション" do
    context "user_idが空の場合" do
      example "投稿に失敗すること" do
        post.user_id = nil
        post.valid?
        expect(post.errors[:user_id]).to include("を入力してください")
      end
    end

    context "areaが空の場合" do
      example "投稿に失敗すること" do
        post.area = ""
        post.valid?
        expect(post.errors[:area]).to include("を入力してください")
      end
    end

    context "post_photoが空の場合" do
      example "投稿に失敗すること" do
        post.post_photo = nil
        post.valid?
        expect(post.errors[:post_photo]).to include("を入力してください")
      end
    end

    context "areaが30文字より多いの場合" do
      example "投稿に失敗する" do
        post.area = "a" * 31
        post.valid?
        expect(post.errors[:area]).to include("は30文字以内で入力してください")
      end
    end

    context "areaが30文字以下の場合" do
      example "投稿に成功する" do
        post.area = "a" * 30
        post.valid?
        expect(post).to be_valid
      end
    end

    context "street_addressが50文字より多いの場合" do
      example "投稿に失敗すること" do
        post.street_address = "a" * 51
        post.valid?
        expect(post.errors[:street_address]).to include("は50文字以内で入力してください")
      end
    end

    context "street_addressが50文字以下場合" do
      example "投稿に成功すること" do
        post.street_address = "a" * 50
        post.valid?
        expect(post).to be_valid
      end
    end

    context "timeが30文字より多いの場合" do
      example "投稿に失敗すること" do
        post.time = "a" * 31
        post.valid?
        expect(post.errors[:time]).to include("は30文字以内で入力してください")
      end
    end

    context "timeが30文字以下場合" do
      example "投稿に成功すること" do
        post.time = "a" * 30
        post.valid?
        expect(post).to be_valid
      end
    end

    context "regular_holidayが30文字より多いの場合" do
      example "投稿に失敗すること" do
        post.regular_holiday = "a" * 31
        post.valid?
        expect(post.errors[:regular_holiday]).to include("は30文字以内で入力してください")
      end
    end

    context "regular_holidayが30文字以下の場合" do
      example "投稿に成功すること" do
        post.regular_holiday = "a" * 30
        post.valid?
        expect(post).to be_valid
      end
    end

    context "urlが50文字より多いの場合" do
      example "投稿に失敗すること" do
        post.url = "a" * 51
        post.valid?
        expect(post.errors[:url]).to include("は50文字以内で入力してください")
      end
    end

    context "urlが50文字以下の場合" do
      example "投稿に成功すること" do
        post.url = "a" * 50
        post.valid?
        expect(post).to be_valid
      end
    end

    context "statonが20文字より多いの場合" do
      example "投稿に失敗すること" do
        post.station = "a" * 21
        post.valid?
        expect(post.errors[:station]).to include("は20文字以内で入力してください")
      end
    end

    context "statonが20文字以下の場合" do
      example "投稿に成功すること" do
        post.station = "a" * 20
        post.valid?
        expect(post).to be_valid
      end
    end

    context "shop_nameが20文字より多いの場合" do
      example "投稿に失敗すること" do
        post.shop_name = "a" * 21
        post.valid?
        expect(post.errors[:shop_name]).to include("は20文字以内で入力してください")
      end
    end

    context "shop_nameが20文字以下場合" do
      example "投稿に成功すること" do
        post.shop_name = "a" * 20
        post.valid?
        expect(post).to be_valid
      end
    end
  end
end
