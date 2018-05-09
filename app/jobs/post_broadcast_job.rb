class PostBroadcastJob < ApplicationJob
  queue_as :urgent

  def perform(post)
  	ActionCable.server.broadcast('chat_room', render_post(post))
  end

  private

  def render_post(post)
  	ApplicationController.renderer.render( partial: '/posts/post_comment', locals: { post: post } )
  end
end
