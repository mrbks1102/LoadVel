require "rails_helper"

RSpec.describe "Toppages", type: :system do
  let(:user) { create(:user) }

  describe "トップページ" do
    before do
      visit root_path
    end

    context "ログイン時" do
      before do
        sign_in user
      end

      example "LOGINボタンが非表示であること" do
        visit root_path
        expect(current_path).to eq root_path
        expect(page).not_to have_content "LOGIN"
      end

      example "SIGNUPボタンが非表示であること" do
        visit root_path
        expect(current_path).to eq root_path
        expect(page).not_to have_content "SIGN UP"
      end

      example "POSTボタンが表示されていること" do
        expect(page).to have_content "POST"
      end
    end

    context "非ログイン時" do
      example "LOGINボタンが表示されていること" do
        expect(page).to have_content "LOGIN"
      end

      example "SIGNUPボタンが表示されていること" do
        expect(page).to have_content "SIGN UP"
      end

      example "POSTボタンが表示されていること" do
        expect(page).to have_content "POST"
      end
    end
  end
end
