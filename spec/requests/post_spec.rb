require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }

  let(:test_post) { create(:post, user: user) }
  let(:photo_path) { File.join(Rails.root, 'spec/image/main_top.jpg') }
  let(:post_photo) { Rack::Test::UploadedFile.new(photo_path) }
  let(:post_params) { { area: 'area', post_photo: post_photo } }

  describe 'index' do
    before { get posts_path }

    example 'リクエストが成功すること' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'show' do
    before { get post_path(test_post.id) }

    example 'リクエストが成功すること' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'new' do
    context 'ログイン時' do
      before do
        sign_in user
        get new_post_path
      end

      example 'リクエストが成功すること' do
        expect(response).to have_http_status(200)
      end
    end

    context '非ログイン時' do
      before { get new_post_path }

      example 'サインイン画面へリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'create' do
    context 'ログイン時' do
      before { sign_in user }

      example '正常に投稿を作成できること' do
        expect do
          post posts_path, params: { post: post_params }
        end.to change(Post, :count).by(1)
      end
    end

    context '非ログイン時' do
      before { get new_post_path }

      example 'サインイン画面へリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'confirm' do
    context 'ログイン時' do
      before { sign_in user }

      example '値が渡されている時にリクエストが成功すること' do
        expect do
          post confirm_posts_path, params: { post: post_params }
          expect(response).to have_http_status(200)
        end
      end
      
      example '値が渡されていない時にリクエストが失敗すること' do
        expect do
          expect(response).not_to have_http_status(200)
        end
      end
    end

    context '非ログイン時' do
      before { post confirm_posts_path, params: { post: post_params } }

      example 'サインイン画面へリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'back' do
    context 'ログイン時' do
      before { sign_in user }

      example '値が渡されている時にリクエストが成功すること' do
        expect do
          post new_posts_path, params: { post: post_params }
          expect(response).to have_http_status(200)
        end
      end

      example '値が渡されていない時にリクエストが失敗すること' do
        expect do
          expect(response).not_to have_http_status(200)
        end
      end
    end

    context '非ログイン時' do
      before { post new_posts_path, params: { post: post_params } }

      example 'サインイン画面へリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
