class UsersController < ApplicationController
  def create
    user_generator = UserGenerator.new(create_user_params).generate
    render json: user_generator, status: 201
  end

  private
  
  def create_user_params
    {
      email: params[:email],
      password: params[:password],
      confirmation: params[:confirmation],
      first_name: params[:first_name],
      last_name: params[:last_name]
    }
  end
end
