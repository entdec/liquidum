Rails.application.routes.draw do
  resource :accounts
  mount Liquor::Engine => '/liquor'
end
