class OrdersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @orders = Order.where(user_id: current_user.id).order(created_at: 'desc')
    render "index.html.erb"
  end

  def create
    carted_products = CartedProduct.where("status = ? AND user_id = ?", "carted", current_user.id)
    subtotal = 0
    tax = 0
    carted_products.each do |carted_product|
      subtotal += (carted_product.product.price * carted_product.quantity)
      tax += (carted_product.product.tax * carted_product.quantity)
    end
    total = subtotal + tax

    order = Order.new(
      user_id: current_user.id,
      subtotal: subtotal,
      tax: tax,
      total: total
    )
    order.save

    # carted_products.each do |carted_product|
    #   carted_product.status = "purchased"
    #   carted_product.order_id = order.id
    #   carted_product.save
    # end
    carted_products.update_all(status: "purchased", order_id: order.id) #same code as loop above, but only requests from database once rather than once for every 'carted_product'

    flash[:success] = "Ordered successfully!"
    redirect_to "/orders/#{order.id}"
  end

  def show
    if current_user.id != Order.find_by(id: params[:id]).user.id
      flash[:danger] = "That is not your order..."
      redirect_to "/products"
    else
      @order = Order.find_by(id: params[:id])
      @carted_products = CartedProduct.where(order_id: @order.id)
      render "show.html.erb"
    end
  end
end
