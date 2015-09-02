class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User"
	belongs_to :pending_friend, :class_name => "User"
	belongs_to :friend_request, :class_name => "User"

	def self.request(user, friend)
    transaction do
      create(:user => user, :friend => friend, :status => 'pending')
      create(:user => friend, :friend => user, :status => 'requested')
    end
  end

  def self.accept(user, friend)
    transaction do
      accept_one_side(user, friend)
      accept_one_side(friend, user)
    end
  end

  def self.accept_one_side(user, friend)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'accepted'
    request.save!
  end

  def self.unfriend(user, friend)
  	transaction do
  		destroy_one_side(user, friend)
  		destroy_one_side(friend, user)
  	end
  end

  def self.destroy_one_side(user, friend)
  	friendship = find_by_user_id_and_friend_id(user, friend)
  	friendship.destroy
  end

end
