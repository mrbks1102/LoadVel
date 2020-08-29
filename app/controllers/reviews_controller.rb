class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @review = Review.new
  end

  def index
    @post = Post.find(params[:post_id])
    @new_posts = Post.limit(3).order(created_at: :desc)
    @exclusion_post = Post.where.not(id: @post.id)
    @likes_posts = @exclusion_post.where(id: Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    @reviews = @post.reviews
    @user = User.find_by(id: @post.user_id)
  end

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to post_path(@review.post)
  end

  private

  def review_params
    params.require(:review).permit(:post_id, :user_id, :body, :title)
  end
end
