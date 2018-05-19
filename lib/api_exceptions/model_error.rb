module ApiExceptions
  class ModelError < ApiExceptions::BaseException
    def initialize(error_array)
      super(code: 400, messages: error_array)
    end
  end
end
