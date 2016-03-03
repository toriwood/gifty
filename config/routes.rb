Rails.application.routes.draw do
  
  get '/interests' => 'interests#index'
  get '/interests/:id' => 'interests#show', as: "interest"

  post 'gifts/upload' => 'gifts#manual_create'
  post 'gifts/pull' => 'gifts#auto_create'

  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :gifts
  resources :wishlists

  root 'wishlists#index'

end
