class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :list

  before_create :set_defaults

  def pending?
    !accepted
  end

  private

  def set_defaults
    self.accepted ||= false
  end
end
