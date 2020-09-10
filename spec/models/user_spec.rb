require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'create' do
    context "値がバリデーションにかからなかった場合" do
      example '正常にユーザーが作成されること' do
        user = build(:user)
        user.valid?
        expect(user).to be_valid
      end
    end
  end

  describe "バリデーション" do
    context "nameが空の場合" do
      example "登録に失敗する" do
        user.name = ""
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end
    end

    context "nameが50文字以上の場合" do
      example "登録に成功する" do
        user = build(:user, name: "a" * 51)
        user.valid?
        expect(user.errors[:name]).to include("は50文字以内で入力してください")
      end
    end

    context "emailが空の場合" do
      example "登録に失敗する" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
    end

    context "emailが重複している場合" do
      example "登録に失敗する" do
        other_user = build(:user, email: user.email)
        other_user.valid?
        expect(other_user.errors[:email]).to include("はすでに存在します")
      end
    end

    context "パスワードが6文字以上の場合" do
      example "登録に成功する" do
        user = build(:user, password: "a" * 6, password_confirmation: "a" * 6)
        user.valid?
        expect(user).to be_valid
      end
    end

    context "passwordが空の場合" do
      example "登録に失敗する" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
    end

    context "passwordが6文字未満の場合" do
      example "登録に失敗する" do
        user = build(:user, password: "a" * 3)
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end
  end
end
