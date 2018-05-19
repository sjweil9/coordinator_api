class Task < ApplicationRecord
  validates :title, length: { in: 1..50, message: 'must be between 1 and 50 characters.' }
  validates :description, length: { in: 1..150, message: 'must be between 1 and 150 characters.' }
  validates :status_in_valid_list
  validates :due_at_in_future, on: :create

  belongs_to :list

  has_many :task_users
  has_many :completed_task_users, -> { where(completed: true) }, class_name: 'TaskUser'
  has_many :claimed_task_users, -> { where(completed: false) }, class_name: 'TaskUser'
  
  has_many :users, through: :task_users
  has_many :completed_users, through: :completed_task_users, source: :user
  has_many :claimed_users, through: :claimed_task_users, source: :user

  before_create :set_defaults
  before_save :convert_times_to_utc

  private

  def set_defaults
    self.status = 'unclaimed'
    self.completed = false
  end

  def convert_times_to_utc
  end

  # validation methods
  
  def status_in_valid_list
    errors.add(:status, "must be in: #{valid_stauses.join(', ')}") unless valid_status?
  end

  def valid_status?
    %w[completed claimed unclaimed].include?(status)
  end

  def due_at_in_future
    return unless due_at.present?
    errors.add(:due_at, 'must be in the future.') unless due_at.to_utc > Time.zone.now
  end
end
