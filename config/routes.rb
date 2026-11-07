Liquidum::Engine.routes.draw do
  resources :variables, only: :index
  resources :conversions
  resources :sandbox
  post 'render_only', to: 'sandbox#render_only'
end
