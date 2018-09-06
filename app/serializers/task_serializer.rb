class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :completed_at, :due_at, :created_at, :updated_at
end
