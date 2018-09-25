class InvitesController < ApplicationController
  def accept
    Invite.find(pure[:id]).update(accepted: pure[:accepted])
    render json: { status: 'success' }, status: 200
  end

  def index
    invites = Invite.includes(list: %i[created_user]).references(list: %i[created_user]).where(user_id: pure[:user_id], accepted: false)
    render json: invites, include: ['list', 'list.created_user'], each_serializer: InviteSerializer, status: 200
  end

  def create
    existing_invite = Invite.find_by(user_id: pure[:invited_user_id], list_id: pure[:id])
    Invite.create(accepted: false, user_id: pure[:invited_user_id], list_id: pure[:id]) unless existing_invite
    render json: List.find(pure[:id]), status: 201
  end

  private

  def pure
    params.permit(%i[id invited_user_id accepted user_id]).to_h
  end
end
