require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  let(:user_params) { { profile: "こんにちは" } }

  describe "show" do
    before { get user_path(user.id) }

    example "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end
  end

  describe "edit" do
    context "ログイン時" do
      before { sign_in user }

      example "リクエストが成功すること" do
        get edit_user_path(user.id)
        expect(response).to have_http_status(200)
      end
    end

    context "非ログイン時" do
      before { get edit_user_path(user.id) }

      example "サインイン画面へリダイレクトされること" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "destroy" do
    context "ログイン時" do
      context "本人の場合" do
        before { sign_in user }

        example "正常に削除できること" do
          expect do
            delete user_path(user.id)
          end.to change(User, :count).by(-1)
        end

        example "削除後にトップにリダイレクトされること" do
          delete user_path(user.id)
          expect(response).to redirect_to root_path
        end
      end

      context "本人でない場合" do
        before { sign_in user2 }

        example "削除されないこと" do
          expect do
            delete user_path(user.id)
          end.to change(User, :count).by(0)
        end
      end
    end

    context "非ログイン時" do
      before { delete user_path(user.id) }

      example "サインイン画面へリダイレクトされること" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
