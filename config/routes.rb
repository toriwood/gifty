Rails.application.routes.draw do
  resources :wishlists
  root 'wishlists#index'

end
