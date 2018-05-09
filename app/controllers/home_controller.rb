class HomeController < ApplicationController
  def index
  end

  def random
  	@posts = Post.all
  	@post = Post.new
  end
end
