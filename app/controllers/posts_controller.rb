class PostsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]

  def index
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created!"
      redirect_to request.referrer || root_url
    else
      render 'static_pages/index'
    end
  end

  def destroy
  end

  private
    def post_params
      params.require(:post).permit(:body)
    end
end
