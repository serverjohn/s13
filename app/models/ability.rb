class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == "admin" or "tservant"
      can :manage, :all
      can :disable, :all
    end
  end
end
