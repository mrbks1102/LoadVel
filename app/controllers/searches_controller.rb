class SearchesController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts_search = @q.result(distinct: true).includes(:categories).order(created_at: :desc)
  end
end
