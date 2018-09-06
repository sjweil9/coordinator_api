class ListsController < ApplicationController
  # remove these - just for dev
  skip_before_action :authenticate_request, only: %i[index]
  skip_before_action :authorize_request, only: %i[index]

  def index
    lists = List.all
    render json: lists, each_serializer: ListSerializer, status: 200
  end
end
