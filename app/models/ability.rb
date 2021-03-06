class Ability
    include CanCan::Ability
    def initialize(user)
        if user.blank?
            cannot :manage, :all
            basic_read_only
        elsif user.admin?
            can :manage, :all
        elsif user.editor?
            login_do
            user_do
            can :create, Post
            can :update, Post
            can :destroy, Post
        else
            login_do
            can :create, Post
            can :update, Post do |post|
                (post.user_id == user.id)
            end
            can :destroy, Post do |post|
                (post.user_id == user.id)
            end
            can :update, User do |user|
                (user.id == user.id)
            end
            basic_read_only
        end
        # Define abilities for the passed in user here. For example:
        #
        #   user ||= User.new # guest user (not logged in)
        #   if user.admin?
        #     can :manage, :all
        #   else
        #     can :read, :all
        #   end
        #
        # The first argument to `can` is the action you are giving the user
        # permission to do.
        # If you pass :manage it will apply to every action. Other common actions
        # here are :read, :create, :update and :destroy.
        #
        # The second argument is the resource the user can perform the action on.
        # If you pass :all it will apply to every resource. Otherwise pass a Ruby
        # class of the resource.
        #
        # The third argument is an optional hash of conditions to further filter the
        # objects.
        # For example, here the user can only update published articles.
        #
        #   can :update, Article, :published => true
        #
        # See the wiki for details:
        # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    end
    protected

    def basic_read_only
        can :read, Finder
        can :read, Post
        can :read, Library
    end
    def login_do
        can :find_daily_news, Finder
        can :create, Library
        can :update, Library do |library|
            (user.posts.published.count >= 2)
        end
        can :destroy, Library do |library|
            (user.posts.published.count >= 2)
        end        
        can :my_posts, Post do |post|
            (post.user_id == user.id)
        end
    end
    def user_do
        can :create, Post
        can :update, Post do |post|
            (post.user_id == user.id)
        end
        can :destroy, Post do |post|
            (post.user_id == user.id)
        end
        can :update, User do |user|
            (user.id == user.id)
        end
        basic_read_only
    end    
end
