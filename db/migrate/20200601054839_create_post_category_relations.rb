class CreatePostCategoryRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :post_category_relations do |t|
      t.references :post, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false
      t.timestamps
    end
  end
end
