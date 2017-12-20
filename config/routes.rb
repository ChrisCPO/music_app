Rails.application.routes.draw do
  root "searches#new"
  resource :search, only: [:new]
  resources :searches, only: [:index]

  resources :artists, only: [:show]
  resources :albums, only: [:show]
  resources :songs, only: [:show]
end
