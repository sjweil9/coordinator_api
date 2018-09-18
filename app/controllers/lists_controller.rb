class ListsController < ApplicationController
  def index
    lists = List.all
    render json: lists, each_serializer: ListSerializer, status: 200
  end

  def show
    list = List.includes(:created_user).find(pure[:id])
    render json: list, include: ['created_user'], status: 200
  end

  def create_for_user
    list_generator = ListGenerator.new(params).generate
    render json: list_generator, status: 201
  end

  def lists_for_user
    @user = User.find(pure[:user_id])
    lists = List.includes(:created_user).select('lists.*, list_users.*').where(list_users: { user_id: @user.id})
    render json: lists.all, each_serialier: ListSerializer, status: 200
  end

  private

  def pure
    params.permit(%i[id user_id]).to_h
  end
end
