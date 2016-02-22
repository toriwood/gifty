Rails.application.routes.draw do
  
  resources :gifts
  resources :wishlists

  root 'wishlists#index'

end
