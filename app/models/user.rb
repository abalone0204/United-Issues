class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  # extend OmniauthCallbacks
  devise :omniauthable, :omniauth_providers => [:facebook]
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable #, :omniauthable

  before_create :format_name
  before_create :check_name
  
  has_many :posts, dependent: :destroy
  has_many :announcements, dependent: :destroy
  has_many :librarizations
  has_many :libraries, :through => :librarizations

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    # raise(ArgumentError,
    #     "Invalid user. Expected an object of class 'User', got #{user.inspect}") unless user.is_a?(User)
    if user.is_a?(User)
      Thread.current[:user] = user
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.remote_avatar_url = (auth.info.image+"?type=normal").gsub('http://','https://') # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def format_name
    self.name = name.gsub(/_/, " ")
  end

  def check_name

  end

end
