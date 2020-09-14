require "rails_helper"

RSpec.describe Contact, type: :model do
  let(:user) { create(:user) }

  let(:contact) { create(:contact) }

  describe "create" do
    context "値が正常に渡されている場合" do
      example "正常に送信されること" do
        expect(contact).to be_valid
      end
    end
  end

  describe "バリデーション" do
    context "nameが空の場合" do
      example "登録に失敗する" do
        contact.name = ""
        contact.valid?
        expect(contact.errors[:name]).to include("を入力してください")
      end
    end

    context "nameが50文字より多いの場合" do
      example "登録に失敗する" do
        contact.name = "a" * 51
        contact.valid?
        expect(contact.errors[:name]).to include("は50文字以内で入力してください")
      end
    end

    context "nameが50文字以下の場合" do
      example "登録に成功する" do
        contact.name = "a" * 50
        contact.valid?
        expect(contact).to be_valid
      end
    end

    context "emailが空の場合" do
      example "登録に失敗する" do
        contact.email = ""
        contact.valid?
        expect(contact.errors[:email]).to include("を入力してください")
      end
    end

    context "emailが適正な形式である場合" do
      example "登録に成功" do
        contact.email = "test@example.com"
        contact.valid?
        expect(contact).to be_valid
      end
    end

    context "bodyが空の場合" do
      example "登録に失敗する" do
        contact.body = ""
        contact.valid?
        expect(contact.errors[:body]).to include("を入力してください")
      end
    end

    context "bodyが300文字より多いの場合" do
      example "登録に失敗する" do
        contact.body = "a" * 301
        contact.valid?
        expect(contact.errors[:body]).to include("は300文字以内で入力してください")
      end
    end

    context "bodyが300文字以下の場合" do
      example "登録に成功する" do
        contact.body = "a" * 300
        contact.valid?
        expect(contact).to be_valid
      end
    end
  end
end
