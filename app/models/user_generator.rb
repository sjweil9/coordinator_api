class UserGenerator
  include ActiveModel::Serialization
  attr_reader :user, :user_params

  VALID_USER_PARAMS = %i[first_name last_name email password password_confirmation]

  def initialize(params)
    @user_params = params.permit(*VALID_USER_PARAMS)
    @user_params[:password_confirmation] ||= ''
  end

  def generate
    @user = User.new(user_params)
    return user if user.save
    raise ApiExceptions::ModelError, user.errors
  end
end
