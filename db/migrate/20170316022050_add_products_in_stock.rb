class AddProductsInStock < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :in_stock, :boolean
  end
end
