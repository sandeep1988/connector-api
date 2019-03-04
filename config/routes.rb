Rails.application.routes.draw do
  root :to => "welcome#index"
  # get 'call_get_api' => 'connector#call_get_api'
  namespace :api do
  namespace :v1 do
  	resources :users
    resources :connector
    post 'call_get_api' => 'connector#call_get_api'
  end
end
end