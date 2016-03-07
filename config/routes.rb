Rails.application.routes.draw do

  get '/interests' => 'interests#index'
  get '/interests/:id' => 'interests#show', as: "interest"
  match '/gifts/update_image/:id' => 'gifts#update_image', via: [:get, :post]

  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :gifts
  resources :wishlists
  resources :users

  root 'wishlists#index'

end
