module ApiExceptions  
  class AuthenticationError < ApiExceptions::BaseException
    class InvalidToken < ApiExceptions::AuthenticationError
      def initialize
        super(code: 401, messages: [{ token: 'Authentication token invalid or expired' }])
      end
    end
  end
end