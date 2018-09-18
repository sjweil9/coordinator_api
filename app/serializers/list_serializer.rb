class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at

  def self.eager_load_relation(relation)
    relation.includes(:created_user)
  end

  has_one :created_user, serializer: UserSerializer
end
