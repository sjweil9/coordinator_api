class TasksController < ApplicationController
  def index
    tasks = Task.all
    render json: tasks, each_serializer: TaskSerializer, status: 200
  end

  def tasks_for_list
    tasks = Task.where(list_id: params[:id]).includes(:created_user, :completed_user, :claimed_user)
    render json: tasks.all, each_serializer: TaskSerializer, status: 200
  end

  def status
    task = Task.find(params[:task_id])
    raise ApiExceptions::AuthorizationError if task.claimed? && task.claimed_user.id != current_user[:id]
    claimed_user = params[:status] == 'claimed' ? User.find(current_user[:id]) : nil
    task.update(status: params[:status], claimed_user: claimed_user)
    render json: task, include: ['claimed_user', 'created_user', 'completed_user'], serializer: TaskSerializer, status: 200
  end
end
