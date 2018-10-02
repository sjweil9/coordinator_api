class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at

  def self.eager_load_relation(relation)
    relation.includes(:created_user, :pending_users, :followed_users)
  end

  has_one :created_user, serializer: UserSerializer
  has_many :pending_users, each_serializer: UserSerializer
  has_many :followed_users, each_serializer: UserSerializer
  has_many :tasks
end
