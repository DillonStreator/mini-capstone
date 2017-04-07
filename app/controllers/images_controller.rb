class ImagesController < ApplicationController

  def new
    @image = Image.new
    @product = Product.find_by(id: params[:id])
    render "new.html.erb"
  end

  def edit
    @product = Product.find_by(id: params[:id])
    @images = Image.where(product_id: params[:id])
    render "edit.html.erb"
  end

  def create
    image = Image.new(url: params[:url], product_id: params[:id])
    image.save
    flash[:success]= "Image successfully added."
    redirect_to "/images/#{image.product_id}/edit"
  end

  def destroy
    image = Image.find_by(id: params[:id])
    image.destroy
    flash[:danger] = "Image successfully destroyed"
    redirect_to "/images/#{image.product_id}/edit"
  end

  def update
    image = Image.find_by(id: params[:id])
    product = Product.find_by(id: image.product_id)
    image.url = params[:url]
    image.save
    flash[:success]= "Image successfully updated."
    redirect_to "/images/#{image.product_id}/edit"
  end
    
end
