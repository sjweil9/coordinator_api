class ListsChannel < ApplicationCable::Channel
  def subscribed
    puts 'got a subscriber!'
    reject unless list
    stream_for list
  end

  def unsubscribed
    stop_all_streams
  end

  private

  def list
    @list ||= List.find(params[:list_id])
  end
end
