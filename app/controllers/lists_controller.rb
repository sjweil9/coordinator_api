class ListsController < ApplicationController
  def index
    lists = List.all
    render json: lists, each_serializer: ListSerializer, status: 200
  end

  def show
    list = List.includes(:created_user, tasks: %i[claimed_user completed_user created_user]).references(:created_user, tasks: %i[claimed_user completed_user created_user]).where(id: pure[:id])
    render json: list.first, include: ['created_user', 'tasks', 'tasks.claimed_user', 'tasks.completed_user', 'tasks.created_user'], status: 200
  end

  def create_for_user
    list_generator = ListGenerator.new(params).generate
    render json: list_generator, status: 201
  end

  def lists_for_user
    @user = User.find(pure[:user_id])
    lists = List.includes(:created_user, :tasks).select('lists.*, list_users.user_id').where(list_users: { user_id: @user.id})
    render json: lists.all, each_serialier: ListSerializer, status: 200
  end

  private

  def pure
    params.permit(%i[id user_id]).to_h
  end
end
