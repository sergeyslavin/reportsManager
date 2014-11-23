class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.is_admin?
      can :manage, :all
    elsif user.is_reporter?      
      can :manage, Report
      cannot :manage, Template
    else
    	can :read, Report
    end
  end
end
