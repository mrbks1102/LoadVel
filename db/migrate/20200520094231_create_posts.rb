class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :post_photo, null: false
      t.integer :place_name,    null: false, default: "0"
      t.string :area
      t.string :street_address
      t.string :time
      t.string :regular_holiday
      t.string :url
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
