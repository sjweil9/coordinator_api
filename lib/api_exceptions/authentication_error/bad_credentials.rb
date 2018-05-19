module ApiExceptions
  class AuthenticationError < ApiExceptions::BaseException
    class BadCredentials < ApiExceptions::AuthenticationError
      def initialize
        super(code: 401, messages: [{ credentials: 'Invalid credentials provided' }])
      end
    end
  end
end