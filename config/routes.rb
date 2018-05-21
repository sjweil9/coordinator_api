Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/users_list', to: 'users#index'
  post '/users', to: 'users#create'
  get '/users/:user_id', to: 'users#show'
  patch '/users/:user_id', to: 'users#update'

  post '/login', to: 'authentication#login'
end
