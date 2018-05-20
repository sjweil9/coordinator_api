class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[create]
  skip_before_action :authorize_request, only: %i[create]

  def create
    user_generator = UserGenerator.new(params).generate
    render json: user_generator, status: 201
  end

  def show
    user = User.find(params[:user_id])
    render json: user, status: 200
  end
end
