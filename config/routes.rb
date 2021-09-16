Rails.application.routes.draw do
  root to: 'setlists#index'
  resources :setlists
  resources :songs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
