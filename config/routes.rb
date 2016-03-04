Rails.application.routes.draw do
  
  get '/interests' => 'interests#index'
  get '/interests/:id' => 'interests#show', as: "interest"

  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :gifts
  resources :wishlists

  root 'wishlists#index'

end
