Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get 'users/show'
  resources :posts, only: %i(index new create show) do
    collection do
      post :confirm
    end
    resources :photos, only: %i(create)
  end

end
