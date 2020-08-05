class CategoriesController < ApplicationController
  def index
    @post = Post.order(created_at: :desc)
    @category_id = Category.find(params[:category_id])
    @post = Post.includes(:categories).where(post_category_relations: { category_id: @category_id })
  end
end
