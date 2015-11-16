class AdminAbility
  include CanCan::Ability
  def initialize(user)
    if user.admin?
        can :manage, :all
    elsif user.editor?
        cannot :manage, User 
        can :notification, Post
        can :statistics, Post
        can :schedule, Post
        cannot :set_publish_time, Post
        can :read, Post
        can :create, Post
        can :update, Post
        can :destroy, Post
    end
  end
end