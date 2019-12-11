Rails.application.routes.draw do

  root to: 'rms_main#index'
  resources :rms_requests
  resources :rms_clients 
  
  get  '/login', to: 'rms_login#new'
  post '/login', to: 'rms_login#create'
  delete '/logout', to: 'rms_login#destroy'
  
end
