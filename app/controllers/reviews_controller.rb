class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @review = Review.new
  end

  def index
    @post = Post.find(params[:post_id])
    @posts = Post.limit(3).order('created_at DESC')
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
