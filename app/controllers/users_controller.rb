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

  def friends
    invited_friends = user.send(pure[:accepted] == 'true' ? :accepted_friends : :pending_friends)
    invited_by_friends = user.send(pure[:accepted] == 'true' ? :accepted_friended_by_users : :pending_friended_by_users )
    friends = invited_friends + invited_by_friends
    render json: friends, each_serializer: UserSerializer, status: 200
  end

  def current_user_profile
    render json: User.find(current_user[:id]), status: 200
  end

  private

  def user
    @user ||= User.find(current_user[:id])
  end

  def permitted_fields
    %i[accepted user_id]
  end
end
