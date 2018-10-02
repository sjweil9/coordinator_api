class ListUser < ApplicationRecord
  belongs_to :list
  belongs_to :user

  before_create :set_defaults

  private

  def set_defaults
    self.creator ||= false
  end
end
