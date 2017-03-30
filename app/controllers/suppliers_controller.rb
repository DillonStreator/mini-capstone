class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
    render = "index.html.erb"
  end
  def new
    render = "new.html.erb"
  end
  def create
    supplier = Supplier.new(name: params[:name], email: params[:email], phone_number: params[:phone_number])
    supplier.save
    flash[:success]= "Supplier successfully created."
    redirect_to "/products"
  end
  def show
  end
  def edit
  end
  def update
  end
  def destroy
    supplier = Supplier.find_by(id: params[:id])
    supplier.destroy
    flash[:success] = "Supplier successfully destroyed."
    redirect_to "/suppliers"
  end
end
