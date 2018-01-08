Rails.application.routes.draw do
  root "searches#index"

  resource :search, only: [] do
    get "results"
  end
  resources :searches, only: [:index]

  resources :artists, only: [:show]
  resources :albums, only: [:show]
  resources :songs, only: [:show]
end
