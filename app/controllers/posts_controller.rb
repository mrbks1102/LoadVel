class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :confirm, :back]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @post = Post.all.limit(4).order(created_at: :desc)
    @like_posts = @post.likes_posts.limit(4).sort { |a, b| b.likes.count <=> a.likes.count }
    @random_posts = Post.order(Arel.sql("RANDOM()"))
    @noon_posts = @random_posts.noon_posts
    @cafe_posts = @random_posts.rider_cafe_posts
    @q = Post.ransack(params[:q])
    @categories = Category.all
    @posts = Post.all.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.csv { send_data @posts.generate_csv, filename: "posts-#{Time.zone.now.strftime("%Y%m%d%S")}.csv" }
    end
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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
    flash[:notice] = "投稿を編集しました。"
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    flash[:notice] = "投稿を削除しました。"
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

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user.id != current_user.id
      flash[:notice] = "投稿者ではないため権限がありません"
      redirect_to posts_path
    end
  end
end
