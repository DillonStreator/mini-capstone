class ProductsController < ApplicationController

  def index
    if params["category"]
      category = Category.find_by(name: params[:category])
      @products = category.products
    else
      sort_input = params[:sort_by] || "name"
      sort_order = params[:how] || "asc"
      @products = Product.all.order(sort_input => sort_order)
    end
    render "products.html.erb"

  end

  def new
    if params[:new_type] == "product"
      render "new_product.html.erb"
    elsif params[:new_type] == "image"
      render "new_image.html.erb"
    end
  end

  def create_product
    supplier = Supplier.find_by(name: params[:supplier])
    product = Product.new(
      name: params[:product_name],
      price: params[:product_price],
      description: params[:product_description],
      supplier_id: (supplier.id)
    )
    product.save
    image = Image.new(
      url: params[:url],
      product_id: (product.id)
    )
    image.save
    flash[:success]= "Product successfully created."
    redirect_to "/products"
  end
  def create_image
    image = Image.new(url: params[:url], product_id: params[:id])
    image.save
    flash[:success]= "Image successfully added."
    redirect_to "/show/#{params[:id]}"
  end

  def show
    @product = Product.find_by(id: params[:id])
    render "show.html.erb"
  end

  def edit
    if params[:edit_type] == "product"
      @product = Product.find_by(id: params[:id])
      @supplier = Supplier.find_by(id: (@product.supplier_id))
      @suppliers = Supplier.all
      render "edit_products.html.erb"
    elsif params[:edit_type] == "image"
      @product = Product.find_by(id: params[:id])
      @images = Image.where(product_id: params[:id])
      render "edit_images.html.erb"
    end
  end

  def update
    if params[:update_type] == "product"
      product = Product.find_by(id: params[:id])
      product.name = params[:product_name]
      product.price = params[:product_price]
      product.description = params[:product_description]
      product.supplier_id = params[:supplier]
      flash[:success]= "Product successfully updated."
      redirect_to "/show/#{@product.id}"
    elsif params[:update_type] == "image"
      image = Image.find_by(id: params[:id])
      product = Product.find_by(id: image.product_id)
      image.url = params[:url]
      flash[:success]= "Image successfully updated."
      redirect_to "/product/#{product.id}/edit?edit_type=image"
    end
      
  end

  def destroy
    if params[:destroy_type] == "product"
      product = Product.find_by(id: params[:id])
      product.destroy
      flash[:danger] = "Product successfully destroyed"
      redirect_to "/"
    elsif params[:destroy_type] == "image"
      image = Image.find_by(id: params[:id])
      image.destroy
      flash[:danger] = "Image successfully destroyed"
      redirect_to "/product/#{image.product_id}/edit?edit_type=image"
    end
  end

  def search
    @search_name = params[:search_name].capitalize
    products = Product.where("name LIKE ?", "%#{@search_name}%")
    @products = Product.all
    render "search.html.erb"
  end

  def discounts
    @products = Product.where("price < ?", 5).order(name: 'asc')
    render "discounts.html.erb"
  end

  def random_product
    @product = Product.offset(rand(Product.count)).first
    render "show.html.erb"
  end
end
