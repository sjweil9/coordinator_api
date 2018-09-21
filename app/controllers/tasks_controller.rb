class TasksController < ApplicationController
  before_action :authorize!, only: %i[status]

  def index
    tasks = Task.all
    render json: tasks, each_serializer: TaskSerializer, status: 200
  end

  def tasks_for_list
    tasks = Task.where(list_id: params[:id]).includes(:created_user, :claimed_user)
    render json: tasks.all, each_serializer: TaskSerializer, status: 200
  end

  def status
    claimed_user = params[:status] == 'unclaimed' ? nil : User.find(current_user[:id])
    task.update(status: params[:status], claimed_user: claimed_user)
    render json: task, include: ['claimed_user', 'created_user'], serializer: TaskSerializer, status: 200
  end

  def add_task_to_list
    task_generator = TaskGenerator.new(params).generate
    render json: task_generator, status: 201
  end

  def task
    @task ||= Task.find(params[:task_id])
  end

  def authorize!
    raise ApiExceptions::AuthorizationError if task.claimed? && task.claimed_user.id != current_user[:id]
  end
end
