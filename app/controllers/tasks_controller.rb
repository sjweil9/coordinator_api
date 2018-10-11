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
    ActiveRecord::Base.transaction do
      task.update(status: params[:status], claimed_user: claimed_user)
    end
    ListsChannel.broadcast_to list, list.tasks.map { |task| TaskSerializer.new(task).as_json }
    render json: task, include: ['claimed_user', 'created_user'], serializer: TaskSerializer, status: 200
  end

  def add_task_to_list
    new_task = TaskGenerator.new(params).generate
    ListsChannel.broadcast_to list, list.tasks.map { |task| TaskSerializer.new(task).as_json }
    render json: new_task, status: 201
  end

  def delete
    task.destroy
    render json: { status: 'success' }, status: 200
  end

  private

  def task
    @task ||= Task.find(params[:id])
  end

  def list
    @list ||= List.find(params[:list_id])
  end

  def authorize!
    return unless task.claimed? && task.claimed_user.id != current_user[:id]

    message = "Task has already been claimed by #{task.claimed_user.first_name} #{task.claimed_user.last_name}"
    raise ApiExceptions::AuthorizationError.new(message: message)
  end
end
