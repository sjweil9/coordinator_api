module ApiExceptions
  class AuthorizationError < ApiExceptions::BaseException
    def initialize
      super(code: 403, messages: [authorization: 'User not authorized to access this resource.'])
    end
  end
end
