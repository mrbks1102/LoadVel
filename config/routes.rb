Rails.application.routes.draw do
  root to: 'pages#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:show, :edit, :update, :destroy]
  resources :posts, only: [:new, :index, :create, :show] do
    collection do
      post :new, path: :new, as: :new, action: :back
      post :confirm
    end
  end

end
