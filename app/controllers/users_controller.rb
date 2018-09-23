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

  def invites_for_user
    invites = Invite.includes(list: %i[created_user]).references(list: %i[created_user]).where(user_id: params[:user_id], accepted: false)
    render json: invites, include: ['list', 'list.created_user'], each_serializer: InviteSerializer, status: 200
  end

  def accept_invite
    invite = Invite.find(params[:id]).update(accepted: true)
    render json: { status: 'success' }, status: 200
  end

  def current_user_profile
    render json: current_user, status: 200
  end
end
