Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'home', to: 'homes#home', as: 'home'
  get 'search', to: 'homes#search', as: 'search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit, :update]
end
