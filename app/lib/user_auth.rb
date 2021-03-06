class UserAuth
  class <<self
    def encode(user_info, expiration = 24.hours.from_now)
      user_info[:expiration] = expiration
      token = JWT.encode(user_info, Rails.application.credentials.secret_key_base, 'HS256')
      { access_token: token, expiration: expiration }.to_json
    end

    def decode(token)
      Thread.current[:user_info] = nil
      body = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')[0]
      expiration = body.delete('expiration')
      return if body.nil? || expiration.nil? || Time.parse(expiration) < Time.now.utc
      Thread.current[:user_info] = HashWithIndifferentAccess.new body
    rescue StandardError
      nil
    end

    def current_user
      Thread.current[:user_info]
    end
  end
end
