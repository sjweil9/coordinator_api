class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def current_user
    UserAuth.current_user
  end
end
