class ProductsController < ApplicationController

  def index
    @products = Product.all
    @products = @products.sort_by { |a|  a.name }
    render "products.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    product = Product.new(
      name: params[:product_name],
      price: params[:product_price],
      description: params[:product_description],
      image: params[:product_image]
    )
    product.save
    render "create.html.erb"
  end

  def show
    @product = Product.find_by(id: params[:id])
    render "show.html.erb"
  end

  def edit
    @product = Product.find_by(id: params[:id])
    render "edit.html.erb"
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.name = params[:product_name]
    @product.price = params[:product_price]
    @product.image = params[:product_image]
    @product.description = params[:product_description]
    @product.save
    render "update.html.erb"
  end

  def destroy
    product = Product.find_by(id: params[:id])
    product.destroy
    render "destroy.html.erb"
  end

end
