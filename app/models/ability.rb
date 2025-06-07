class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.super_admin?
      can :manage, :all
    elsif user.admin?
      can :manage, User
      can :manage, StaticPage
      can :read, :admin_dashboard
    else
      # Regular users - limited access
      can :read, :admin_dashboard
      can :update, User, id: user.id  # can only edit themselves
    end
  end
end 