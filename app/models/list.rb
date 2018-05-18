class List < ApplicationRecord
    validates :title, length: { in: 1..100, message: 'must be between 1 and 100 characters.' }
    validates :description, length: { in: 1..1000, message: 'must be between 1 and 1000 characters.' }

    has_many :tasks
    has_many :completed_tasks, -> { where(status: 'completed') }, class_name: 'Task'
    has_many :claimed_tasks, -> { where(status: 'claimed') }, class_name: 'Task'
    has_many :unclaimed_tasks, -> { where(status: 'unclaimed') }, class_name: 'Task'

    has_many :list_users
    has_many :created_list_users, -> { where(creator: true) }, class_name: 'ListUser'
    has_many :followed_list_users, -> { where(creator: false) }, class_name: 'ListUser'

    has_many :users, through: :list_users
    has_many :created_users, through: :created_list_users, source: :user
    has_many :followed_users, through: :followed_list_users, source: :user
end
