Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'toppages#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:show, :edit, :update, :destroy]
  resources :posts, only: [:new, :index, :create, :show] do
    resources :reviews, only: [:new, :index, :create]
    resources :favorites, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    collection do
      post :new, path: :new, as: :new, action: :back
      post :confirm
    end
  end
  resources :contacts, only: [:new, :create]
  resources :searches, only: [:index]
  resources :categories, only: [:index]
end
