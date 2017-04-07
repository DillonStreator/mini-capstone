class CartedProductsController < ApplicationController
  before_action :authenticate_user!, except: :create
  before_action :authenticate_admin!, except: [:create, :index]

  def index
    if CartedProduct.where("status = ? AND user_id = ?", "carted", current_user.id).size == 0
      flash[:danger] = "You have no items in your cart! Go ahead and add some."
      redirect_to "/products"
    else
      @carted_products = CartedProduct.where("status = ? AND user_id = ?", "carted", current_user.id)
    end
  end

  def create
    if current_user
      if CartedProduct.find_by(status: 'carted', user_id: current_user.id, product_id: params[:product_id])
        carted_product = CartedProduct.find_by(status: 'carted', user_id: current_user.id, product_id: params[:product_id])
        carted_product.quantity = carted_product.quantity.to_i + params[:quantity].to_i
        if carted_product.save
          flash[:success] = "successfully updated quantity of existing product in cart!"
          redirect_to "/products"
        else
          flash[:danger] = "Quantity can't be less than 1."
          redirect_to "/products/#{params[:product_id]}"
        end
      else
        carted_product = CartedProduct.new(
          quantity: params[:quantity],
          user_id: current_user.id,
          product_id: params[:product_id],
          status: "carted"
        )
        if carted_product.save
          flash[:success] = "successfully new product to cart!"
          redirect_to "/products"
        else
          flash[:danger] = "Quantity can't be less than 1."
          redirect_to "/products/#{params[:product_id]}"
        end
      end
    else
      flash[:danger] = %Q[You must <a href="/signup">sign up</a>/<a href="login">sign in</a> to add items to your cart.]
      redirect_to "/"
    end
  end

  def destroy
    carted_product = CartedProduct.find_by(id: params[:id])
    carted_product.status = "removed"
    carted_product.save
    flash[:success] = "Product successfully deleted!"
    redirect_to "/carted_products"
  end
end
