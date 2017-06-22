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
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:coposition_oauth2]

  after_create :send_admin_mail
  def send_admin_mail
    UserMailer.welcome_email(self).deliver
  end

  def friends?(other_user)
  	friends.include?(other_user)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def feed
    friend_ids = "SELECT friend_id FROM friendships
                     WHERE  user_id = :user_id AND status = 'accepted'"
    Post.where("user_id IN (#{friend_ids})
                     OR user_id = :user_id", user_id: id)
  end
end
