Rails.application.routes.draw do
  resource :accounts
  mount Liquidum::Engine => '/liquidum'
  mount Mensa::Engine, at: '/mensa', as: 'mensa'
end
