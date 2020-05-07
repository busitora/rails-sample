Rails.application.routes.draw do
  # 例外
  get '*not_found', to: 'application#routing_error'
  post '*not_found', to: 'application#routing_error'
  # match '*path', to: 'application#render_404', via: :all if Rails.env.development?

  namespace :admin do
    resources :users
  end
  root 'tasks#index'
  resources :tasks
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
end
