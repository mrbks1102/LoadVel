Rails.application.routes.draw do
  root to: 'pages#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get '/posts/new', to: 'posts#new'
  post '/posts', to: 'posts#create'
  post '/posts/:post_id/photos', to: 'photos#create', as: 'post_photos'

  resources :users, only: [:show, :edit, :update, :destroy]
  resources :posts, only: %i(new index create show) do
    collection do
      post :confirm
    end
    resources :photos, only: %i(create)
  end

end
