class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships, dependent: :destroy
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

  def feed
    friend_ids = "SELECT friend_id FROM friendships
                     WHERE  user_id = :user_id AND status = 'accepted'"
    Post.where("user_id IN (#{friend_ids})
                     OR user_id = :user_id", user_id: id)
  end
end
