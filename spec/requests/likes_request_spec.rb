require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }

  let(:like_post) { create(:post, user: user) }
  let(:like_params) { { post_id: like_post.id, user_id: user.id } }
  

  describe 'create' do
    context 'ログインしている時' do
      before { sign_in user }

      example '正常にいいね出来ること' do
        expect do
          post post_likes_path(like_post.id), params: { like: like_params, format: :js }
        end.to change(Like, :count).by(1)
      end
    end

    context 'ログインしていない時' do
      before { post post_likes_path(like_post.id), params: like_params }

      example 'サインイン画面へリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'destroy' do
    let(:like) { create(:like, user_id: user.id, post_id: like_post.id) }
    let(:likes) { { id: like.id } }
  
    context 'ログインしている時' do
      context '本人の場合' do
        before do
           sign_in user
        end

        example 'いいね解除できること' do
          expect do
            expect { delete :destroy, format: :json, params: { post_id: like_post.id, user_id: user.id, id: like.id } }.to change{ like_post.likes.count }.by(-1)
          end
        end
      end
    end
  end
end
