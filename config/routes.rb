Rails.application.routes.draw do
  
  devise_for :users
  resources :gifts
  resources :wishlists

  root 'wishlists#index'

end
