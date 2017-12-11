Rails.application.routes.draw do
  root "searches#new"
  resource :search, only: [:new, :create, :show]
end
