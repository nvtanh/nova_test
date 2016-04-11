Rails.application.routes.draw do
  root to: 'boats#index'

  devise_for :users, path: "/", only: [:registrations, :sessions]
  resources :boats do
    resources :goods
  end
end
