class PostsCommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  end
end
