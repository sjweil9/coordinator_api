Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/users', to: 'users#index'
  post '/users', to: 'users#create'
  get '/users/current', to: 'users#current_user_profile'
  get '/users/:user_id', to: 'users#show'
  patch '/users/:user_id', to: 'users#update'

  post '/login', to: 'authentication#login'

  get '/tasks', to: 'tasks#index'

  get '/users/:user_id/lists', to: 'lists#lists_for_user'
  post '/users/:user_id/lists', to: 'lists#create_for_user'
  
  get '/lists', to: 'lists#index'
  get '/lists/:id', to: 'lists#show'
  get '/lists/:id/tasks', to: 'tasks#tasks_for_list'
  post '/lists/:id/tasks', to: 'tasks#add_task_to_list'

  patch '/lists/:list_id/tasks/:id/status', to: 'tasks#status'
  delete '/tasks/:id', to: 'tasks#delete'
end
