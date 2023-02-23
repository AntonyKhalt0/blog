# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'posts#index'
  get 'posts/my', to: 'posts#index', my: true
  resources :posts do
    resources :comments, only: %i[create destroy]
  end
end
