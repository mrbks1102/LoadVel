class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.limit(4).order('created_at DESC')
  end


  def new 
    @post = Post.new
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def confirm
    @post = Post.new(post_params)
    return if @post.valid?
    flash.now[:alert] = '入力に不備がありました。'
    render :new
  end

  def back
    @post = Post.new(post_params)
    render :new
  end

  def create
    @post = Post.new(post_params)
    if
      @post.save
      redirect_to root_path
      flash[:notice] = "投稿が完了しました。"
    else
      render :new
    end
  end
  private

  def post_params
    params.require(:post).permit(:post_photo,
                                 :post_photo_cache,
                                 :place_name,
                                 :area,
                                 :street_address,
                                 :time,
                                 :regular_holiday,
                                 :url,
                                 :station,
                                 :shop_name,
                                 { :category_ids=> [] }).merge(user_id: current_user.id)
  end
end
