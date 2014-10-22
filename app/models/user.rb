class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  extend OmniauthCallbacks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  before_create :format_name
  has_many :posts

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
  
  private

  def format_name
    self.name = name.gsub(/_/, " ")  
  end
  
end
