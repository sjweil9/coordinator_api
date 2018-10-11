class TaskGenerator
  include ActiveModel::Serialization
  attr_reader :task, :task_params

  VALID_TASK_PARAMS = %i[title description due_at status list_id]

  def initialize(params)
    @task_params = params.permit(*VALID_TASK_PARAMS)
    @task_params[:created_user] = current_user
    @task_params[:claimed_user] = current_user if task_params[:status] == 'claimed'
  end

  def generate
    @task = Task.new(task_params)
    return task if task.save
    raise ApiExceptions::ModelError, task.errors
  end

  def current_user
    @current_user ||= User.find(UserAuth.current_user[:id])
  end
end
