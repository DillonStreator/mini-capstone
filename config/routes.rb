Rails.application.routes.draw do
  get "/products_view" => "products#products_view_method"
end
