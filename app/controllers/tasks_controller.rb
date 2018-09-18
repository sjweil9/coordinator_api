class TasksController < ApplicationController
  def index
    tasks = Task.all
    render json: tasks, each_serializer: TaskSerializer, status: 200
  end

  def tasks_for_list
    tasks = Task.where(list_id: params[:id]).includes(:created_user, :completed_user, :claimed_user)
    render json: tasks.all, each_serializer: TaskSerializer, status: 200
  end
end
