class LikesController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]

  def create
  	@like = current_user.likes.build(post_id: params[:post_id])
  	if @like.save
  	  flash[:notice] = "Post liked!"
  	  redirect_to request.referrer || root_url
  	else
  	  flash[:notice] = "Error liking post"
  	  redirect_to request.referrer || root_url
  	end
  end

  def destroy
  	Like.find(params[:id]).destroy
    flash[:notice] = "Post unliked!"
    redirect_to request.referrer || root_url
  end

end
