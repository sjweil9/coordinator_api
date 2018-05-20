module ApiExceptions
  class NotFound < ApiExceptions::BaseException
    def initialize(message)
      super(code: 404, messages: [id: message])
    end
  end
end
