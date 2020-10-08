require "rails_helper"

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }

  let(:posts) { create(:post, user: user) }

  describe "投稿ページ" do
    before do
      sign_in user
      visit new_post_path
    end

    context "フォームの入力が正しい場合" do
      example "投稿確認画面に遷移し投稿できること" do
        fill_in "post[area]", with: "area"
        attach_file "post[post_photo]", "spec/image/main_top.jpg"
        click_on "確認へ進む"
        expect(current_path).to eq confirm_posts_path
        click_on "投稿する"
        expect(page).to have_content "投稿が完了しました。"
      end
    end

    context "フォームの入力が誤っている場合" do
      example "エラーメッセージを表示する" do
        attach_file "post[post_photo]", "spec/image/main_top.jpg"
        click_on "確認へ進む"
        expect(page).to have_content "入力に不備がありました。"
      end
    end
  end

  describe "投稿詳細ページ" do
    context "ログイン時" do
      before do
        sign_in user
        visit post_path(posts.id)
      end

      example "投稿削除ボタンが機能すること" do
        click_on "削除"
        expect(page).to have_content "投稿を削除しました"
      end

      example "投稿編集ボタンが機能すること" do
        click_on "編集"
        click_on "更新する"
        expect(page).to have_content "投稿を編集しました"
      end

      example "いいねボタンが表示されていること" do
        expect(page).to have_selector ".fa-thumbs-up"
      end

      example "お気に入りボタンが表示されていること" do
        expect(page).to have_selector ".fa-thumbtack"
      end
    end

    context "非ログイン時" do
      before do
        sign_out user
        visit post_path(posts.id)
      end

      example "いいねボタンが非表示であること" do
        expect(page).to have_selector(".fa-thumbs-up", visible: false)
      end

      example "お気に入りボタンが非表示であること" do
        expect(page).to have_selector(".fa-thumbtack", visible: false)
      end
    end
  end
end
