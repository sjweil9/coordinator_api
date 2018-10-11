class ListsChannel < ApplicationCable::Channel
  def subscribed
    puts 'got a subscriber!'
    list = List.find(params[:list_id])
    stream_for list
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
