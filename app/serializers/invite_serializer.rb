class InviteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :list_id, :accepted

  def self.eager_load_relation(relation)
    relation.includes(:list)
  end

  has_one :list, serializer: ListSerializer
end
