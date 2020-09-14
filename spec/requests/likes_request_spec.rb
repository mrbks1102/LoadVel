require "rails_helper"

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:like_post) { create(:post, user: user) }
  let(:like_params) { { user_id: user.id, post_id: like_post.id } }

  describe "create" do
    context "ログインしている時" do
      before { sign_in user }

      example "正常にいいね出来ること" do
        expect do
          post post_likes_path(like_post.id), params: { like: like_params, format: :js }
        end.to change(Like, :count).by(1)
      end
    end

    context "ログインしていない時" do
      before { post post_likes_path(like_post.id), params: like_params }

      example "サインイン画面へリダイレクトされること" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "destroy" do
    let!(:like) { create(:like, user_id: user.id, post_id: like_post.id) }
    context "ログイン時" do
      before { sign_in user }

      example "いいね解除できること" do
        expect do
          delete post_like_path(post_id: like_post.id, id: like.id), params: { like: like.id, format: :js }
        end.to change(Like, :count).by(-1)
      end
    end

    context "非ログイン時" do
      before { delete post_like_path(post_id: like_post.id, id: like.id), params: { like: like.id, format: :js } }

      example "サインイン画面にリダイレクトされること" do
        expect do
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end
end
