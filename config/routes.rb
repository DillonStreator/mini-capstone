Rails.application.routes.draw do
  get "/" => "products#index"
  get "/products" => "products#index"
  get "/products/new" => "products#new"
  post "/products/create_product" => "products#create_product"
  post "/products/create_supplier" => "products#create_supplier"
  post "/products/create_image" => "products#create_image"
  get "/show/:id" => "products#show"
  get "/products/:id/edit" => "products#edit"
  patch "/products/:id" => "products#update"
  delete "/products/:id" => "products#destroy"
  post "/products/search" => "products#search"
  get "/products/discounts" => "products#discounts"
  get "/products/randomproduct" => "products#random_product"

  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/users/:id/edit" => "users#edit"
  patch "/users/:id" => "users#update"


  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/orders" => "orders#index"
  post "/orders" => "orders#create"
  get "/orders/:id" => "orders#show"

  get "/suppliers" => "suppliers#index"
  get "/suppliers/new" => "suppliers#new"
  post "/suppliers" => "suppliers#create"
  get "/suppliers/:id" => "suppliers#show" #need to add this
  get "/suppliers/:id/edit" => "suppliers#edit"
  post "/suppliers/:id" => "suppliers#update"
  delete "/suppliers/:id" => "suppliers#destroy"

  get "/carted_products" => "carted_products#index"
  post "/carted_products/:product_id" => "carted_products#create"
  delete "/carted_products/:id" => "carted_products#destroy"

  get "/categories/new" => "categories#new"
  post "/categories" => "categories#create"

end
