class UsersController < ApplicationController
  # remove index from these - only for dev
  skip_before_action :authenticate_request, only: %i[create index]
  skip_before_action :authorize_request, only: %i[create index]

  def create
    user_generator = UserGenerator.new(params).generate
    render json: user_generator, status: 201
  end

  def show
    user = User.find(params[:user_id])
    render json: user, status: 200
  end

  def index
    users = User.all
    render json: users, each_serializer: UserSerializer, status: 200
  end
end
