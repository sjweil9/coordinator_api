class List < ApplicationRecord
  validates :title, length: { in: 1..100, message: 'Title must be between 1 and 100 characters' }
  validates :description, length: { in: 1..1000, message: 'Description must be between 1 and 1000 characters' }

  has_many :tasks
  has_many :completed_tasks, -> { where(status: 'completed') }, class_name: 'Task'
  has_many :claimed_tasks, -> { where(status: 'claimed') }, class_name: 'Task'
  has_many :unclaimed_tasks, -> { where(status: 'unclaimed') }, class_name: 'Task'

  has_many :list_users
  has_one :created_list_user, -> { where(creator: true) }, class_name: 'ListUser'
  has_many :followed_list_users, -> { where(creator: false) }, class_name: 'ListUser'

  has_many :users, through: :list_users
  has_one :created_user, through: :created_list_user, source: :user
  has_many :followed_users, through: :followed_list_users, source: :user

  has_many :invitees, class_name: 'Invite'
  has_many :accepted_invitees, -> { where(accepted: true) }, class_name: 'Invite'
  has_many :pending_invitees, -> { where(accepted: false) }, class_name: 'Invite'

  has_many :invited_users, through: :invitees, source: :user
  has_many :accepted_users, through: :accepted_invitees, source: :user
  has_many :pending_users, through: :pending_invitees, source: :user
end
