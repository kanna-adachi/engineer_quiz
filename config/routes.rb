Rails.application.routes.draw do

  resources :admin
  resources :uploads
  root 'uploads#index'
end
