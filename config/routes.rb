Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  # TODO: showとindex以外は後で作成します
end
