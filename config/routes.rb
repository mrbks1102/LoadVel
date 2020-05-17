Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: 'pages#index'
  resources :users, only: [:show, :edit, :update]
  resources :posts, only: %i(new index create show) do
    collection do
      post :confirm
    end
    resources :photos, only: %i(create)
  end

end
