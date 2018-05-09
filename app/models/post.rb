class Post < ApplicationRecord
  belongs_to :user
  after_create_commit :bradcast_post

  private

  def bradcast_post
  	PostBroadcastJob.perform_later self
  end
end
