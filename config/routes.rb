Liquidum::Engine.routes.draw do
  resources :variables, only: :index
  resources :filters, only: :index
  resources :tags, only: :index
  resources :conversions, only: %i[index create]
  resources :sandbox, except: %i[show destroy]
end
