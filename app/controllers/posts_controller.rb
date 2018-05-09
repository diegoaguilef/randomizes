class PostsController < ApplicationController
	before_action :set_post, only: [:edit, :show, :destroy]

	layout false
	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		params[:post].merge!(user_id: current_user.id)
		@post = Post.new(post_params)
		respond_to do |format|
			if @post.save
				format.html {render action: :index }
				format.js { render json: {status: 200, text: 'Posted Successfully'}}
			else
				puts @post.errors.messages
				format.html {render :new }
			end
		end
	end

	private 

	def post_params
		params.require(:post).permit(:comment, :user_id)
	end

	def set_post
		@post = Post.find(params[:id])
	end
end
