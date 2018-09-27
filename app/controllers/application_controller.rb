class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  rescue_from ApiExceptions::BaseException, with: :render_error_response

  before_action :authenticate_request, :authorize_request

  private
  
  def render_error_response(error)
    render json: error, serializer: ApiExceptionSerializer, status: error.code
  end

  def catch_not_found(error)
    render_error_response(ApiExceptions::NotFound.new(error.message))
  end

  def authenticate_request
    UserAuth.decode(request.headers[:authorization])
    raise ApiExceptions::AuthenticationError::InvalidToken unless current_user
  end

  def current_user
    UserAuth.current_user
  end

  def authorize_request
    raise ApiExceptions::AuthorizationError if unauthorized_resource?
  end

  def unauthorized_resource?
    params[:user_id] && params[:user_id].to_i != current_user[:id].to_i
  end

  def pure
    params.permit(permitted_fields).to_h
  end

  def permitted_fields
    # override me
    []
  end
end
