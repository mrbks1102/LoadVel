require "rails_helper"

RSpec.describe "Favorites", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:favo_post) { create(:post, user: user) }
  let(:favo_params) { { user_id: user.id, post_id: favo_post.id } }

  describe "create" do
    context "ログインしている時" do
      before { sign_in user }

      example "正常にいいね出来ること" do
        expect do
          post post_favorites_path(favo_post.id), params: { favorite: favo_params, format: :js }
        end.to change(Favorite, :count).by(1)
      end
    end

    context "ログインしていない時" do
      before { post post_favorites_path(favo_post.id), params: favo_params }

      example "サインイン画面へリダイレクトされること" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "destroy" do
    let!(:favorite) { create(:favorite, user_id: user.id, post_id: favo_post.id) }
    context "ログイン時" do
      before { sign_in user }

      example "いいね解除できること" do
        expect do
          delete post_favorite_path(post_id: favo_post.id, id: favorite.id), params: { favorite: favorite.id, format: :js }
        end.to change(Favorite, :count).by(-1)
      end
    end

    context "非ログイン時" do
      before do
        delete post_favorite_path(post_id: favo_post.id, id: favorite.id), params: { favorite: favorite.id, format: :js }
      end

      example "サインイン画面にリダイレクトされること" do
        expect do
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end
end
