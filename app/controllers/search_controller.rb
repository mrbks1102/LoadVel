class SearchController < ApplicationController
  def index
    @q = Post.search(params[:q])
    @posts_search = @q.result.includes(:categories)
  end
end
