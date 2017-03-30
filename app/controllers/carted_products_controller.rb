class CartedProductsController < ApplicationController
  def index
    if CartedProduct.where("status = ? AND user_id = ?", "carted", current_user.id).size == 0
      flash[:danger] = "You have no items in your cart! Go ahead and add some."
      redirect_to "/products"
    else
      @carted_products = CartedProduct.where("status = ? AND user_id = ?", "carted", current_user.id)
    end
  end

  def create
    carted_products = CartedProduct.where("status = ? AND user_id = ?", "carted", current_user.id)
    if current_user
      if CartedProduct.find_by(status: 'carted', user_id: current_user.id, product_id: params[:product_id])
        carted_product = CartedProduct.find_by(status: 'carted', user_id: current_user.id, product_id: params[:product_id])
        carted_product.quantity = carted_product.quantity.to_i + params[:quantity].to_i
        carted_product.save
        flash[:success] = "successfully updated quantity of existing product in cart!"
        redirect_to "/products"
      else
        carted_product = CartedProduct.new(
          quantity: params[:quantity],
          user_id: current_user.id,
          product_id: params[:product_id],
          status: "carted"
        )
        carted_product.save
        flash[:success] = "successfully new product to cart!"
        redirect_to "/products"
      end
    else
      flash[:danger] = "You are not signed in.."
      redirect_to "/login"
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
