class ProductsController < ApplicationController

  def products_view_method
    @products = Product.all
    render "products_view.html.erb"
  end

end
