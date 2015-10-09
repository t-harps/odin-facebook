class StaticPagesController < ApplicationController
  before_action :user_signed_in?, only: [:index]

  def index
  	@post = current_user.posts.build
  	@feed_items = current_user.feed
  end
end
