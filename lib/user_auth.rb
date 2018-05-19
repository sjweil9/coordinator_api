class UserAuth
  class <<self
    def encode(user_info, expiration = 24.hours.from_now)
      user_info[:expiration] = expiration
      JWT.encode(user_info, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      Thread.current[:user_info] = HashWithIndifferentAccess.new body
    rescue StandardError
      nil
    end

    def current_user
      Thread.current[:user_info]
    end
  end
end
