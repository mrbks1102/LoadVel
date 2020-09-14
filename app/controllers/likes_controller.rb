class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    if @like.save
      respond_to :js
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  private

  def like_params
    params.permit(:post_id)
  end
end
