Rails.application.routes.draw do
  root "dashboards#show"

  resource :dashboard, only: [:show]

  resource :search, only: [] do
    get "results"
  end
  resources :searches, only: [:index]

  resources :artists, only: [:show]
  resources :albums, only: [:show]
  resources :songs, only: [:show]
end
