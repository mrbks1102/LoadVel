class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @review = Review.new
  end

  def index
    @post = Post.find(params[:post_id])
    @new_posts = Post.limit(3).order(created_at: :desc)
    @none_post = Post.where.not(id: @post.id)
    @likes_posts = @none_post.likes_posts.limit(3).sort { |a, b| b.likes.count <=> a.likes.count }
    @reviews = @post.reviews
    @user = User.find_by(id: @post.user_id)
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @post = @review.post
    if @review.save
      @post.create_notification_review!(current_user, @review.id)
      redirect_to post_path(@review.post)
      flash[:notice] = "投稿が完了しました。"
    else
      redirect_back(fallback_location: new_post_review_path)
      flash[:alert] = "入力に不備がありました。"
    end
  end

  private

  def review_params
    params.require(:review).permit(:post_id, :user_id, :body, :title)
  end
end
