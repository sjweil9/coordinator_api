class ApplicationController < ActionController::API
  rescue_from ApiExceptions::BaseException, with: :render_error_response

  private
  
  def render_error_response(error)
    render json: error, serializer: ApiExceptionSerializer, status: error.code
  end
end
