Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  root to: "toppages#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks",
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: [:show, :edit, :update, :destroy]
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :reviews, only: [:index, :new, :create, :destroy]
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
  resources :abouts, only: [:index]
  resources :static_pages, only: [:index]
  resources :privacies, only: [:index]
  resources :notifications, only: [:index]
end
