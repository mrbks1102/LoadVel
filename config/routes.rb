Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: 'pages#index'

  get '/users/:id', to: 'users#show', as: 'user'

  resources :posts, only: %i(new index create show) do
    collection do
      post :confirm
    end
    resources :photos, only: %i(create)
  end

end
