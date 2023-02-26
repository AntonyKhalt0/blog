# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root to: 'posts#index'
  get 'user/following', to: "users#following"
  get 'user/followers', to: "users#followers"
  get 'posts/my', to: 'posts#index', my: true
  get 'posts/following', to: 'posts#index', following: true
  resources :posts do
    resources :comments, only: %i[create destroy]
  end
  resources :profiles, only: %i[show]
  resources :relationships, only: %i[create destroy]
end
