class StaticPagesController < ApplicationController
  before_action :user_signed_in?, only: [:index]

  def index
  	if user_signed_in?
  	  @post = current_user.posts.build
  	  @feed_items = current_user.feed
  	end
  end
end
