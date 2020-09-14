require "rails_helper"

RSpec.describe "Review", type: :system do
  let(:user) { create(:user) }

  describe "コメント投稿ページ" do
    before do
      visit new_contact_path
    end

    context "フォームの入力が正しい時" do
      example "投稿に成功し、フラッシュメッセージを表示する" do
        fill_in "contact[name]", with: "name"
        fill_in "contact[email]", with: "test@example.com"
        fill_in "contact[body]", with: "body"
        click_button "送信する"
        expect(page).to have_content "問い合わせ内容を送信しました。"
      end
    end

    context "nameが空欄の場合" do
      example "投稿に失敗し、フラッシュメッセージを表示する" do
        fill_in "contact[email]", with: "test@example.com"
        fill_in "contact[body]", with: "body"
        click_button "送信する"
        expect(page).to have_content "入力に不備がありました。"
      end
    end

    context "emailが空欄の場合" do
      example "投稿に失敗し、フラッシュメッセージを表示する" do
        fill_in "contact[name]", with: "name"
        fill_in "contact[body]", with: "body"
        click_button "送信する"
        expect(page).to have_content "入力に不備がありました。"
      end
    end

    context "bodyが空欄の場合" do
      example "投稿に失敗し、フラッシュメッセージを表示する" do
        fill_in "contact[name]", with: "name"
        fill_in "contact[email]", with: "test@example.com"
        click_button "送信する"
        expect(page).to have_content "入力に不備がありました。"
      end
    end
  end
end
