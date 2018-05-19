class UserGenerator
  include ActiveModel::Serialization
  attr_reader :user, :email, :password, :first_name, :last_name, :confirmation

  def initialize(email:, password:, confirmation:, first_name:, last_name:)
    @email = email
    @password = password
    @first_name = first_name
    @last_name = last_name
    @confirmation = confirmation
  end

  def generate
    @user = User.new(create_user_params)
    return user if user.save
    raise ApiExceptions::ModelError.new(user.errors)
  end

  private

  def create_user_params
    {
      email: email,
      password: password,
      first_name: first_name,
      last_name: last_name,
      password_confirmation: confirmation
    }
  end
end
