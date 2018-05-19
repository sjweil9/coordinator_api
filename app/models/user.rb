class User < ApplicationRecord
  include ActiveModel::Serialization
  has_secure_password
  
  validates :first_name, :last_name,
            length: { in: 2..20, message: 'must be between 2 and 20 characters.' },
            format: {
              with: /\A[a-zA-Z.\s]+\z/, message: 'may only contain letters or periods.'
            }
  validates :email,
            length: { in: 5..75, message: 'must be between 5 and 75 characters.' },
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i, message: 'format invalid.'
            },
            uniqueness: { message: 'already registered.' }
  validates :password,
            format: {
              with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%&?]).{8,72}\z/,
              message: 'format invalid.'
            },
            length: {
              minimum: 8, message: 'must be at least 8 characters.'
            }

  before_create :set_defaults
  before_save :set_cases

  has_many :list_users, dependent: :destroy
  has_many :created_list_users, -> { where(creator: true) }, class_name: 'ListUser'
  has_many :followed_list_users, -> { where(creator: false) }, class_name: 'ListUser'

  has_many :lists, through: :list_users
  has_many :created_lists, through: :created_list_users, source: :list
  has_many :followed_lists, through: :followed_list_users, source: :list

  has_many :task_users, dependent: :destroy
  has_many :completed_task_users, -> { where(completed: true) }, class_name: 'TaskUser'
  has_many :claimed_task_users, -> { where(completed: false) }, class_name: 'TaskUser'
  
  has_many :tasks, through: :task_users
  has_many :completed_tasks, through: :completed_task_users, source: :task
  has_many :claimed_tasks, through: :claimed_task_users, source: :task

  has_many :invites, dependent: :destroy
  has_many :accepted_invites, -> { where(accepted: true) }, class_name: 'Invite'
  has_many :pending_invites, -> { where(accepted: false) }, class_name: 'Invite'
  
  has_many :invited_lists, through: :invites, source: :list
  has_many :accepted_lists, through: :accepted_invites, source: :list
  has_many :pending_lists, through: :pending_invites, source: :list


  def activate_email
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def unlock_account
    self.account_locked = false
    self.login_attempts = 0
    self.last_attempt = DateTime.now
    self.unlock_token = nil
    save!(:validate => false)
  end

  private

  def set_defaults
    self.email_confirmed = false
    self.account_locked = false
    self.login_attempts = 0
    self.last_attempt = DateTime.now
    self.unlock_token = nil
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end

  def set_cases
    email.downcase!
  end
end
