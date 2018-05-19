module ApiExceptions
  class BaseException < StandardError
    include ActiveModel::Serialization
    attr_reader :status, :code, :messages

    ERROR_DESCRIPTION = proc do |code, messages|
      { status: 'error', code: code, messages: messages }
    end

    def initialize(code:, messages:)
      ERROR_DESCRIPTION.call(code, messages).map do |key, value|
        instance_variable_set("@#{key}".to_sym, value)
      end
    end
  end
end
