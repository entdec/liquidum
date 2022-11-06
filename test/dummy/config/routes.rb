Rails.application.routes.draw do
  resource :accounts
  mount Liquidum::Engine => '/liquidum'
end
