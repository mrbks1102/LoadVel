Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: 'posts#index'

  get 'users/show'
  resources :posts, only: %i(new create show) do
    collection do
      post :confirm
    end
    resources :photos, only: %i(create)
  end

end
