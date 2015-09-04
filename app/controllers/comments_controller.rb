class CommentsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy, :edit, :update]

  def create
  	@comment = current_user.comments.build(comment_params)
  	if @comment.save
  	  flash[:notice] = "Comment posted!"
  	  redirect_to request.referrer || root_url
  	else
  	  flash[:notice] = "Error commenting on post, #{comment_params}, #{params[:body]}, #{params[:post_id]}"
  	  redirect_to request.referrer || root_url
  	end
  end

  def destroy
  	Comment.find(params[:id]).destroy
    flash[:notice] = "Comment deleted!"
    redirect_to request.referrer || root_url
  end

  def edit
  end

  def update
  end

  private
    def comment_params
      params.require(:comment).permit(:post_id, :body)
    end
end
