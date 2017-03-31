class CategoriesController < ApplicationController
  
  before_action :authenticate_admin!, except: [:index, :show]

  def new
    render "new.html.erb"
  end
  def create
    category = Category.new(name: params[:name])
    category.save
    flash[:success] = "Category was successfully created."
    redirect_to "/products"
  end
end
