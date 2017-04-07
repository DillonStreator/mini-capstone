class ProductsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]

  def index
    if params["category"]
      category = Category.find_by(name: params[:category])
      @products = category.products
    elsif params["discounts"] == 'true'
      @products = Product.where("price < ?", 5).order(name: 'asc')
    elsif params['random_product'] == 'true'
      @product = Product.offset(rand(Product.count)).first
      redirect_to "/products/#{@product.id}" and return
    elsif params["search"]
      @products = Product.where("lower(name) LIKE ?", "%#{(params[:search]).downcase}%")
    else
      sort_input = params[:sort_by] || "name"
      sort_order = params[:how] || "asc"
      @products = Product.all.order(sort_input => sort_order)
    end
    render "products.html.erb"
  end

  def new
    @product = Product.new
    render "new.html.erb"
  end

  def create_product
    supplier = Supplier.find_by(name: params[:supplier])
    @product = Product.new(
      name: params[:product_name],
      price: params[:product_price],
      description: params[:product_description],
      supplier_id: (supplier.id)
    )
    if @product.save
      image = Image.new(
        url: params[:url],
        product_id: (product.id)
      )
      image.save
      flash[:success]= "Product successfully created."
      redirect_to "/products"
    else
      render "new.html.erb"
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    render "show.html.erb"
  end

  def edit
    @product = Product.find_by(id: params[:id])
    @supplier = Supplier.find_by(id: (@product.supplier_id))
    @suppliers = Supplier.all
    render "edit.html.erb"
  end

  def update
    product = Product.find_by(id: params[:id])
    product.name = params[:product_name]
    product.price = params[:product_price]
    product.description = params[:product_description]
    product.supplier_id = params[:supplier]
    flash[:success]= "Product successfully updated."
    redirect_to "/show/#{@product.id}"
  end

  def destroy
    product = Product.find_by(id: params[:id])
    product.destroy
    flash[:danger] = "Product successfully destroyed"
    redirect_to "/"
  end
end
