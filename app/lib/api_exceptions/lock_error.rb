module ApiExceptions
  class LockError < ApiExceptions::BaseException
    def initialize(message)
      super(code: 423, messages: "Another user already performed this action.")
    end
  end
end
