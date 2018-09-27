class FriendshipsController < ApplicationController
  def create
    existing_friendship = Friendship.find_by(user_id: pure[:user_id], friend_id: pure[:friend_id])
    Friendship.create(accepted: false, user_id: pure[:user_id], friend_id: pure[:friend_id]) unless existing_friendship
    render json: { status: 'success' }, status: 201
  end

  def accept
    Friendship.find_by(friend_id: pure[:user_id], user_id: pure[:friend_id]).update(accepted: true)
    render json: { status: 'success' }, status: 200
  end

  private

  def permitted_fields
    %i[user_id friend_id]
  end
end
