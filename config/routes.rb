Liquidum::Engine.routes.draw do
  resources :completions
  resources :conversions
  resources :sandbox
  post 'render_only', to: 'sandbox#render_only'
end
