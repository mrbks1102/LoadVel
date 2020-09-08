require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:user) { create(:user) }

  let(:review_post) { create(:post, user: user) }
  let(:review_params) { { title: "title", body: "body", post_id: review_post.id, user_id: user.id } }

  describe "new" do
    context "ログイン時" do
      before do
        sign_in user
        get new_post_review_path(review_post.id)
      end

      example "リクエストが成功すること" do
        expect(response).to have_http_status(200)
      end
    end

    context "非ログイン時" do
      before { get new_post_review_path(review_post.id) }

      example "サインイン画面へリダイレクトされること" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "index" do
    context "ログイン時" do
      before do
        sign_in user
        get post_reviews_path(review_post.id)
      end

      example "リクエストが成功すること" do
        expect(response).to have_http_status(200)
      end
    end

    context "非ログイン時" do
      before { get post_reviews_path(review_post.id) }

      example "サインイン画面へリダイレクトされること" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'create' do
    context 'ログイン時' do
      before { sign_in user }

      example '正常に投稿を作成できること' do
        expect do
          post post_reviews_path(review_post.id), params: { review: review_params }
        end.to change(Review, :count).by(1)
      end
    end

    context '非ログイン時' do
      before { post post_reviews_path(review_post.id) }

      example 'サインイン画面へリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
