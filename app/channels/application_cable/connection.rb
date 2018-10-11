module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
 
    def connect
      puts 'connected!'
      self.current_user = UserAuth.current_user
    end
  end
end
