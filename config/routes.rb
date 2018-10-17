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
  get '/users/:user_id/friends', to: 'users#friends'
  get '/users/:user_id/friends/pending', to: 'users#pending_friends'
  get '/users/:user_id/not_friends', to: 'users#not_friends'

  patch '/friendships/:id', to: 'friendships#update'
  
  post '/users/:user_id/friends', to: 'friendships#create'
  patch '/users/:user_id/friends/:friend_id', to: 'friendships#accept'

  get '/users/:user_id/invites', to: 'invites#index'
  patch '/users/:user_id/invites/:id/accepted', to: 'invites#accept'
  
  get '/lists', to: 'lists#index'
  get '/lists/:id', to: 'lists#show'
  delete '/lists/:id', to: 'lists#delete'
  get '/lists/:id/tasks', to: 'tasks#tasks_for_list'
  post '/lists/:list_id/tasks', to: 'tasks#add_task_to_list'
  post '/lists/:id/invitees', to: 'invites#create'

  patch '/lists/:list_id/tasks/:id/status', to: 'tasks#status'
  delete '/tasks/:id', to: 'tasks#delete'

  mount ActionCable.server => '/cable'
end
