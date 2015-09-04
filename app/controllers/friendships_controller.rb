class FriendshipsController < ApplicationController

	def create
		@friend = User.find(params[:friend_id])
		if current_user.friend_requests.include?(@friend)
		  Friendship.accept(current_user, @friend)
		  flash[:notice] = "Accepted friend request!"
		  respond_to do |format|
            format.html { redirect_to current_user }
            format.js
          end
		else
		  Friendship.request(current_user, @friend)
		  flash[:notice] = "Sent friend request"
		  respond_to do |format|
            format.html { redirect_to @friend }
            format.js
          end
		end
	end

	def destroy
		@friend = Friendship.find(params[:id]).friend
		Friendship.unfriend(current_user, @friend)
		flash[:notice] = "Unfriended"
		respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
	end
end
