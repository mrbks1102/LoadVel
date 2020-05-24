class PostsController < ApplicationController
  before_action :authenticate_user!

  def new 
    @post = Post.new
  end

  def index
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    if @post.post_photo.present?
      @post.save
      redirect_to root_path
      flash[:notice] = "投稿が保存されました"
    else
      redirect_to root_path
      flash[:alert] = "投稿に失敗しました"
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_photo,
                                 :place_name,
                                 :area,
                                 :street_address,
                                 :time,
                                 :regular_holiday,
                                 :url,
                                 :station,
                                 :shop_name).merge(user_id: current_user.id)
  end
end
