Rails.application.routes.draw do
  root :to => "welcome#index"
  get 'call_get_api' => 'connector#call_get_api'
  resources :users 
end