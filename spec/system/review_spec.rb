require "rails_helper"

RSpec.describe "Review", type: :system do
  let(:user) { create(:user) }

  let(:review_post) { create(:post, user: user) }
  let(:review_params) { { title: "title", body: "body", post_id: review_post.id, user_id: user.id } }

  describe "コメント投稿ページ" do
    before do
      sign_in user
      visit new_post_review_path(review_post.id)
    end

    context "フォームの入力が正しい時" do
      example "投稿に成功し、フラッシュメッセージを表示する" do
        fill_in "review[title]", with: "title"
        fill_in "review[body]", with: "body"
        click_button "投稿する"
        expect(page).to have_content "投稿が完了しました。"
      end
    end

    context "titleが空欄の場合" do
      example "投稿に失敗し、フラッシュメッセージを表示する" do
        fill_in "review[body]", with: "body"
        click_button "投稿する"
        expect(page).to have_content "入力に不備がありました。"
      end
    end

    context "bodyが空欄の場合" do
      example "投稿に失敗し、フラッシュメッセージを表示する" do
        fill_in "review[title]", with: "title"
        click_button "投稿する"
        expect(page).to have_content "入力に不備がありました。"
      end
    end
  end
end
