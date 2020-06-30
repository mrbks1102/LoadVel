class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true, null: false
      t.text :title
      t.text :body
      t.timestamps
    end
  end
end
