require "rails_helper"

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  let(:guest_user) { create(:user, name: "guest", email: "guest@example.com") }

  describe "会員登録ページ" do
    before do
      visit new_user_registration_path
    end

    context "フォームの入力が正しい時" do
      example "登録に成功し、フラッシュメッセージを表示する" do
        fill_in "user[name]", with: "name"
        fill_in "user[email]", with: "test@example.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_on "新規登録"
        expect(page).to have_content "アカウント登録が完了しました。"
        expect(current_path).to eq posts_path
      end
    end

    context "フォームでnameが空欄の場合" do
      example "登録に失敗し、エラーメッセージを表示する" do
        fill_in "user[email]", with: "test@example.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_on "新規登録"
        expect(page).to have_content "名前を入力してください"
      end
    end

    context "フォームでemailが空欄の場合" do
      example "登録に失敗し、エラーメッセージを表示する" do
        fill_in "user[name]", with: "name"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_on "新規登録"
        expect(page).to have_content "メールアドレスを入力してください"
      end
    end

    context "フォームでpasswordが空欄の場合" do
      example "登録に失敗し、エラーメッセージを表示する" do
        fill_in "user[name]", with: "name"
        fill_in "user[email]", with: "test@example.com"
        fill_in "user[password_confirmation]", with: "password"
        click_on "新規登録"
        expect(page).to have_content "パスワードを入力してください"
      end
    end

    context "フォームでpassword_confirmationが空欄の場合" do
      example "登録に失敗し、エラーメッセージを表示する" do
        fill_in "user[name]", with: "name"
        fill_in "user[email]", with: "test@example.com"
        fill_in "user[password]", with: "password"
        click_on "新規登録"
        expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
      end
    end

    context "フォームでpasswordとpassword_confirmationが一致しない場合" do
      example "登録に失敗し、エラーメッセージを表示する" do
        fill_in "user[name]", with: "name"
        fill_in "user[email]", with: "test@example.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "pass"
        click_on "新規登録"
        expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
      end
    end
  end

  describe "ログインページ" do
    before do
      visit new_user_session_path
    end

    context "フォームの入力が正しい時" do
      example "ログインに成功し、フラッシュメッセージを表示する" do
        fill_in "user[email]", with: "#{user.email}"
        fill_in "user[password]", with: "password"
        click_button "ログイン"
        expect(page).to have_content "ログインしました"
        expect(current_path).to eq posts_path
      end
    end

    context "パスワードの入力が誤っている時" do
      example "ログインに失敗し、フラッシュメッセージを表示する" do
        fill_in "user[email]", with: "#{user.email}"
        fill_in "user[password]", with: "pass"
        click_button "ログイン"
        expect(page).to have_content "メールアドレス もしくはパスワードが不正です。"
      end
    end

    context "パスワードが空欄の場合" do
      example "ログインに失敗し、フラッシュメッセージを表示する" do
        fill_in "user[email]", with: "#{user.email}"
        click_button "ログイン"
        expect(page).to have_content "メールアドレス もしくはパスワードが不正です。"
      end
    end

    context "emailが空欄の場合" do
      example "ログインに失敗し、フラッシュメッセージを表示する" do
        fill_in "user[password]", with: "password"
        click_button "ログイン"
        expect(page).to have_content "メールアドレス もしくはパスワードが不正です。"
      end
    end
  end

  describe "アカウント情報編集ページ" do
    before do
      sign_in user
      visit edit_user_registration_path
    end

    context "有効なプロフィールを更新する時" do
      example "更新に成功する" do
        fill_in "user[name]", with: "test"
        click_button "変更する"
        expect(page).to have_content "アカウント情報を変更しました。"
        expect(current_path).to eq user_path(user.id)
      end
    end

    context "誤ったプロフィールを更新する時" do
      example "更新に失敗する" do
        fill_in "user[name]", with: "test"
        fill_in "user[email]", with: ""
        click_button "変更する"
        expect(page).to have_content "メールアドレスを入力してください"
      end
    end

    context "ゲストユーザーの場合" do
      example "更新に失敗する" do
        sign_out user
        sign_in guest_user
        visit edit_user_registration_path
        fill_in "user[email]", with: "user@example.com"
        click_button "変更する"
        expect(page).to have_content "ゲストユーザーの情報編集はできません。"
        expect(current_path).to eq root_path
      end
    end
  end

  describe "ユーザーセッティングページ", js: true do
    before do
      sign_in user
      visit edit_user_path(user.id)
    end

    example "ログアウトに成功する" do
      click_on "ログアウト"
      sign_out user
      expect(page).to have_content "ログアウトしました。"
      expect(current_path).to eq root_path
    end

    example "アカウントを削除に成功する" do
      click_on "アカウント削除"
      page.accept_confirm "本当に削除しますか？"
      expect(page).to have_content "ユーザーを削除しました"
      expect(current_path).to eq root_path
    end

    context "ゲストユーザーの場合" do
      example "削除に失敗する" do
        sign_out user
        sign_in guest_user
        visit edit_user_path(guest_user.id)
        click_on "アカウント削除"
        page.accept_confirm "本当に削除しますか？"
        expect(page).to have_content "ゲストユーザーの削除はできません。"
      end
    end
  end

  describe "マイページ", js: true do
    before do
      sign_in user
      visit user_path(user.id)
    end

    context "バイクアイコンをタップした時" do
      example "メッセージを表示する" do
        find(".user_nav").find(".fa-motorcycle").click
        expect(page).to have_content "まだ投稿はありません"
      end
    end

    context "コメントアイコンをタップした時" do
      example "メッセージを表示する" do
        find(".user_nav").find(".fa-comments").click
        expect(page).to have_content "まだコメントした投稿はありません"
      end
    end

    context "いいねアイコンをタップした時" do
      example "メッセージを表示する" do
        find(".user_nav").find(".fa-thumbs-up").click
        expect(page).to have_content "まだいいねした投稿はありません"
      end
    end

    context "お気に入りアイコンをタップした時" do
      example "メッセージを表示する" do
        find(".user_nav").find(".fa-thumbtack").click
        expect(page).to have_content "まだお気に入りの投稿はありません"
      end
    end
  end
end
