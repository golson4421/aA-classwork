Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :users
  # get 'users/', to: 'users#index'
  # post 'users/', to: 'users#create'
  # get 'users/new', to: 'users#new', as: 'new_user'
  # get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  # get 'users/:id', to: 'users#show', as: 'user'
  # patch 'users/:id', to: 'users#update'
  # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'

  resources :users, only:[:index, :create, :show, :update, :destroy] do 
    resources :artworks, only:[:index] do
      resources :comments, only:[:index]
    end
    resources :comments, only:[:index] #users/:user_id/comments #users/comments/:user_id
  end
  
  resources :artworks, only:[:create, :show, :update, :destroy] do
    resources :comments, only:[:index]  # artworks/:artwork_id/comment
  end

  # get '/users/:user_id/artworks' to: 'artworks#index'

  # post 'share/:artwork_id/:user_id', to: 'artwork_shares#create'
  # delete 'share/:artwork_id/:user_id', to: 'artwork_shares#destroy'

  resource :artwork_shares, only:[:create, :destroy]
  resource :comments, only:[:create, :destroy]
end