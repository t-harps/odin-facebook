class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def show
  	@post = current_user.posts.build
  	@user = User.find(params[:id])
  end
end
