class ListsController < ApplicationController
  def index
    lists = List.all
    render json: lists, each_serializer: ListSerializer, status: 200
  end

  def create_for_user
    list_generator = ListGenerator.new(params).generate
    render json: list_generator, status: 201
  end

  def lists_for_user
    @user = User.find(params[:user_id])
    lists = List.includes(:created_user).select('lists.*, list_users.*').where(list_users: { user_id: @user.id})
    render json: lists.all, each_serialier: ListSerializer, status: 200
  end
end
