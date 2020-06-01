class AddShopnameToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :station, :string
    add_column :posts, :shop_name, :string
  end
end
Category.create(name: "夜にオススメ")
