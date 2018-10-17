class ListsController < ApplicationController
  before_action :authorize_ownership!, only: %i[add_invitee_to_list delete]
  before_action :authorize_membership!, only: %i[show]

  def index
    lists = List.all
    render json: lists, each_serializer: ListSerializer, status: 200
  end

  def show
    list_with_joins = list_base_query.where(id: pure[:id])
    render json: list_with_joins.first, include: ['created_user', 'pending_users', 'followed_users', 'tasks', 'tasks.claimed_user', 'tasks.created_user'], status: 200
  end

  def delete
    list.destroy
    render json: { status: 'success' }, status: 204
  end

  def create_for_user
    list_generator = ListGenerator.new(params).generate
    render json: list_generator, status: 201
  end

  def lists_for_user
    lists = list_base_query.where(list_users: { user_id: pure[:user_id] })
      .or(list_base_query.where(followed_list_users_lists_join: { user_id: pure[:user_id] }))
    render json: lists.all, each_serialier: ListSerializer, status: 200
  end

  private

  def permitted_fields
    %i[id user_id invited_user_id]
  end

  def list
    @list ||= List.find(pure[:id])
  end

  def list_base_query
    List
      .includes(:created_user, :pending_users, :followed_users, tasks: %i[claimed_user created_user])
      .references(:created_user, :pending_users, :followed_users, tasks: %i[claimed_user created_user])
  end

  def authorize_ownership!
    raise ApiExceptions::AuthorizationError unless list&.created_user&.id == current_user[:id]
  end

  def authorize_membership!
    raise ApiExceptions::AuthorizationError unless list&.belongs_to_user?
  end
end
