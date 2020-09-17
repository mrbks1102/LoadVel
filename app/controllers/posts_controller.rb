class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :confirm, :back]
  Noon = 2
  Cafe = 3

  def index
    @post = Post.all.limit(4).order(created_at: :desc)
    @like_posts = @post.likes_posts.sort { |a, b| b.likes.count <=> a.likes.count }
    @random_posts = Post.order(Arel.sql("RANDOM()"))
    @noon_posts = @random_posts.includes(:categories).limit(4).where(post_category_relations: { category_id: Noon })
    @cafe_posts = @random_posts.includes(:categories).limit(4).where(post_category_relations: { category_id: Cafe })
    @q = Post.ransack(params[:q])
    @categories = Category.all
  end

  def show
    @post = Post.find(params[:id])
    @new_posts = Post.limit(3).order(created_at: :desc)
    @none_post = Post.where.not(id: @post.id)
    @likes_posts = @none_post.likes_posts.limit(3).sort { |a, b| b.likes.count <=> a.likes.count }
    @reviews = @post.reviews.limit(2).order(created_at: :desc)
    @user = User.find_by(id: @post.user_id)
    gon.post = @post
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
    flash.now[:alert] = "入力に不備がありました。"
    render :new
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
