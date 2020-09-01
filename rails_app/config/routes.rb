Rails.application.routes.draw do
  root 'static_pages#home'
  get 'users/:id', to: "static_pages#home"
  get 'users/:id/edit' , to: "static_pages#home"
  get '/login' , to: "static_pages#home"
  delete '/logout', to: "api/v1/sessions#destroy"
  get 'items/new' , to: "static_pages#home"
  get 'items/:id' , to: "static_pages#home"
  get 'items/:id/edit' , to: "static_pages#home"
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :sessions
      resources :users
      resources :items
    end
  end
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
