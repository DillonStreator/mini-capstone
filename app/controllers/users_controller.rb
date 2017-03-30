class UsersController < ApplicationController
  def new
    render 'new.html.erb'
  end

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      session[:user_id] = user.id
      flash[:success] = 'Successfully created account!'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/signup'
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    render "edit.html.erb"
  end

  def update
    user = User.find_by(id: params[:id])
    user.name = params[:name]
    user.email = params[:email]
    user.save
    flash[:success] = "successfully updated your information."
    redirect_to "/products"
  end
end
