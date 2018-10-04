class FriendshipSerializer < ActiveModel::Serializer
  attributes :id, :friend_id, :user_id, :created_at, :accepted

  def self.eager_load_relation(relation)
    relation.includes(:friend, :user)
  end

  belongs_to :friend
  belongs_to :user
end
