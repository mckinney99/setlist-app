Rails.application.routes.draw do
  get '/', to: 'setlists#home'
  resources :setlists
  resources :songs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
