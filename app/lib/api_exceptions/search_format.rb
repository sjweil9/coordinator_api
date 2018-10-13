module ApiExceptions
  class SearchFormatError < ApiExceptions::BaseException
    def initialize
      super(code: 400, messages: [format: 'Search format invalid, consult API documentation.'])
    end
  end
end
