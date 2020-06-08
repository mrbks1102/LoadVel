class PostCategoryRelation < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :category, optional: true
end
