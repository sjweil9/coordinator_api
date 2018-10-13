module ApiExceptions
  class AuthorizationError < ApiExceptions::BaseException
    def initialize(message: 'User not authorized to access this resource')
      messages = [
        {
          authorization: message,
        },
      ]
      super(code: 403, messages: messages)
    end
  end
end
