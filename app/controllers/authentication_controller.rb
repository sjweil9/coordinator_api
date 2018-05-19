class AuthenticationController < ApplicationController
  def login
    return render json: UserAuth.encode(user.as_hash) if user&.authenticate(params[:password])
    raise ApiExceptions::AuthenticationError::BadCredentials
  end

  private
  
  def user
    @user ||= User.find_by(email: params[:email])
  end
end
