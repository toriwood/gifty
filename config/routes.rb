Rails.application.routes.draw do
  
  get 'interests/index'

  get 'interests/show'

  devise_for :users
  resources :gifts
  resources :wishlists

  root 'wishlists#index'

end
