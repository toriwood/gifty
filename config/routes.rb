Rails.application.routes.draw do

  get 'relationships/create'
  get 'relationships/destroy'

  get 'users/:id/gifts' => 'users#gifts', as: "user_gifts"
  get 'users/:id/followers' => 'users#followers', as: "user_followers"
  get 'user/:id/following' => 'users#following', as: "user_following"
  get 'user/:id/celebrating' => 'users#celebrating', as: "user_celebrating"

  get 'gifts/:id/fulfilled' => 'gifts#fulfill', as: "gift_fulfill"
 
  get '/interests' => 'interests#index'
  get '/interests/:id' => 'interests#show', as: "interest"
  match '/gifts/update_image/:id' => 'gifts#update_image', via: [:get, :post]

  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :wishlists
  resources :users
  resources :relationships
  
  resources :gifts do 
    collection do 
      match 'search' => 'gifts#search', via: [:get, :post], as: :search
    end
  end
  
  root 'gifts#index'

end
