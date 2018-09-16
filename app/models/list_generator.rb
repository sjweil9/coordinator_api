class ListGenerator
  include ActiveModel::Serialization
  attr_reader :list, :list_params, :user

  VALID_LIST_PARAMS = %i[title description]

  def initialize(params)
    @list_params = params.permit(*VALID_LIST_PARAMS)
    @user = User.find(params[:user_id]) if params[:user_id]
  end

  def generate
    @list = List.new(list_params)
    @list.created_user = @user if @user
    return list if list.save
    raise ApiExceptions::ModelError, list.errors
  end
end
