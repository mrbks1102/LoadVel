class PostsController < ApplicationController
  before_action :authenticate_user!

  def new 
    @post = Post.new
  end

  def index
  end

  def show
  end

  def confirm
    @post = Post.new(post_params)
    return if @post.valid?
    render :new
  end

  def back
    @post = Post.new(post_params)
    render :new
  end

  def create
    @post = Post.new(post_params)
    if @post.post_photo.present?
      @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(
                                 :post_photo,
                                 :post_photo_cache,
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
