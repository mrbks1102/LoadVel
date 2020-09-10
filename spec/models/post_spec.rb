require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  let(:post) { create(:post, user: user) }

  describe 'create' do
    context "値がバリデーションにかからなかった場合" do
      example '正常に投稿が作成されること' do
        expect(post).to be_valid
      end
    end
  end

  describe 'バリデーション' do
    context "areaが空の場合" do
      example '投稿に失敗すること' do
        post = build(:post, area: nil)
        post.valid?
        expect(post).to be_invalid
      end
    end

    context "post_photoが空の場合" do
      example '投稿に失敗すること' do
        post = build(:post, post_photo: nil)
        post.valid?
        expect(post).to be_invalid
      end
    end

    context "areaが30文字より多いの場合" do
      example "投稿に失敗する" do
        post = build(:post, area: "a" * 31)
        post.valid?
        expect(post).to be_invalid
      end
    end

    context "areaが30文字以下の場合" do
      example "投稿に成功する" do
        post = build(:post, area: "a" * 15)
        post.valid?
        expect(post).to be_valid
      end
    end

    context "street_addressが50文字より多いの場合" do
      example '投稿に失敗すること' do
        post = build(:post, street_address: "a" * 51)
        post.valid?
        expect(post).to be_invalid
      end
    end

    context "street_addressが50文字以下場合" do
      example '投稿に成功すること' do
        post = build(:post, street_address: "a" * 50)
        post.valid?
        expect(post).to be_valid
      end
    end

    context "timeが30文字より多いの場合" do
      example '投稿に失敗すること' do
        post = build(:post, time: "a" * 31)
        post.valid?
        expect(post).to be_invalid
      end
    end

    context "timeが30文字以下場合" do
      example '投稿に成功すること' do
        post = build(:post, time: "a" * 30)
        post.valid?
        expect(post).to be_valid
      end
    end

    context "regular_holidayが30文字より多いの場合" do
      example '投稿に失敗すること' do
        post = build(:post, regular_holiday: "a" * 31)
        post.valid?
        expect(post).to be_invalid
      end
    end

    context "regular_holidayが30文字以下の場合" do
      example '投稿に成功すること' do
        post = build(:post, regular_holiday: "a" * 30)
        post.valid?
        expect(post).to be_valid
      end
    end

    context "urlが50文字より多いの場合" do
      example '投稿に失敗すること' do
        post = build(:post, url: "a" * 51)
        post.valid?
        expect(post).to be_invalid
      end
    end

    context "urlが50文字以下の場合" do
      example '投稿に成功すること' do
        post = build(:post, url: "a" * 50)
        post.valid?
        expect(post).to be_valid
      end
    end

    context "statonが20文字より多いの場合" do
      example '投稿に失敗すること' do
        post = build(:post, station: "a" * 21)
        post.valid?
        expect(post).to be_invalid
      end
    end

    context "statonが20文字以下の場合" do
      example '投稿に成功すること' do
        post = build(:post, station: "a" * 20)
        post.valid?
        expect(post).to be_valid
      end
    end

    context "shop_nameが20文字より多いの場合" do
      example '投稿に失敗すること' do
        post = build(:post, shop_name: "a" * 21)
        post.valid?
        expect(post).to be_invalid
      end
    end

    context "shop_nameが20文字以下場合" do
      example '投稿に失敗すること' do
        post = build(:post, shop_name: "a" * 20)
        post.valid?
        expect(post).to be_valid
      end
    end
  end
end
