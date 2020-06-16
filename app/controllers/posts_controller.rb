class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.limit(4).order('created_at DESC')

  end

  def show
    @post = Post.find(params[:id])
    @posts = Post.limit(3).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.category_ids = session[:category_ids]
    if @post.save
      redirect_to @post
      flash[:notice] = "投稿が完了しました。"
    else
      render :new
    end
  end

  def confirm
    @post = Post.new(post_params)
    session[:category_ids] = @post.category_ids
    return if @post.valid?
    flash.now[:alert] = '入力に不備がありました。'
    render :new
  end

  def category
    @category = Category.find(params[:id])
    @post = Post.includes(:categories).where(post_category_relations: { category_id: @category })
    @posts = Post.find(params[:id])
  end

  def back
    @post = Post.new(post_params)
    render :new
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
                                 category_ids: []).merge(user_id: current_user.id)
  end
end
