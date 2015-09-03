class User < ActiveRecord::Base
  has_many :posts
  has_many :friendships
  has_many :friends, -> { where "status = 'accepted'" }, :through => :friendships
  has_many :pending_friends, -> { where "status = 'pending'" }, :through => :friendships, source: :friend
  has_many :friend_requests, -> { where "status = 'requested'" }, :through => :friendships, source: :friend

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def friends?(other_user)
  	friends.include?(other_user)
  end

end
