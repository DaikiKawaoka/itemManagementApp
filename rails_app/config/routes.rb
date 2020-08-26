Rails.application.routes.draw do
  root 'static_pages#home'
  get 'users/:id', to: "static_pages#home"
  get 'users/:id/edit' , to: "static_pages#home"
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :sessions
      resources :users
    end
  end
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
