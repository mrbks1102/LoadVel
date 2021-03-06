class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :destroy]
  before_action :check_guest, only: [:destroy]

  def show
    @user = User.includes(:likes, :posts, :favorites).find_by(id: params[:id])
    @reviews = @user.reviews_posts.uniq
  end

  def edit
  end

  def destroy
    @user = User.find(current_user.id)
    @user.destroy
    redirect_to root_path
    flash[:alert] = "ユーザーを削除しました"
  end

  def check_guest
    if current_user.email == "guest@example.com"
      redirect_to root_path
      flash[:alert] = "ゲストユーザーの削除はできません。"
    end
  end
end
