class TasksController < ApplicationController
  # remove these - just for dev
  skip_before_action :authenticate_request, only: %i[index]
  skip_before_action :authorize_request, only: %i[index]

  def index
    tasks = Task.all
    render json: tasks, each_serializer: TaskSerializer, status: 200
  end
end
