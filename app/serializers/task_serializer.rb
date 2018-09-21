class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :completed_at, :due_at, :created_at, :updated_at

  def self.eager_load_relation(relation)
    relation.includes(:created_user, :claimed_user)
  end

  has_one :created_user, serializer: UserSerializer
  has_one :claimed_user, serializer: UserSerializer
end
