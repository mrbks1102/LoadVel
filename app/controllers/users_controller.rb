class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :destroy]

  def show
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
    @posts = Post.where(user_id: @user.id)
    @favorites = Favorite.where(user_id: @user.id)
    @reviews = Review.where(user_id: @user.id)
  end

  def edit
  end

  def destroy
    @user = User.find(current_user.id)
    @user.destroy
    redirect_to root_path
    flash[:alert] = 'ユーザーを削除しました'
  end
end
