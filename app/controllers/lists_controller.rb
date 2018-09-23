class ListsController < ApplicationController
  before_action :authorize_ownership!, only: %i[add_invitee_to_list]

  def index
    lists = List.all
    render json: lists, each_serializer: ListSerializer, status: 200
  end

  def show
    list_with_joins = list_base_query.where(id: pure[:id])
    render json: list_with_joins.first, include: ['created_user', 'invited_users', 'followed_users', 'tasks', 'tasks.claimed_user', 'tasks.created_user'], status: 200
  end

  def create_for_user
    list_generator = ListGenerator.new(params).generate
    render json: list_generator, status: 201
  end

  def lists_for_user
    @user = User.find(pure[:user_id])
    lists = list_base_query.where(list_users: { user_id: @user.id})
    render json: lists.all, each_serialier: ListSerializer, status: 200
  end

  def add_invitee_to_list
    Invite.create(accepted: false, user_id: pure[:invited_user_id], list_id: pure[:id])
    render json: list, status: 201
  end

  private

  def pure
    params.permit(%i[id user_id invited_user_id]).to_h
  end

  def list
    @list ||= List.find(pure[:id])
  end

  def list_base_query
    List
      .includes(:created_user, :invited_users, :followed_users, tasks: %i[claimed_user created_user])
      .references(:created_user, :invited_users, :followed_users, tasks: %i[claimed_user created_user])
  end

  def authorize_ownership!
    raise ApiExceptions::AuthorizationError unless list&.created_user&.id == current_user[:id]
  end
end
