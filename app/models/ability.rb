class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :read, Site, id: user.site
      can [:read, :update, :assign, :all, :create, :export], Device, site_id: user.site
      can [:read, :update, :assign, :history, :all, :create, :export], Supply, site_id: user.site
      can :manage, :static_page
    end
  end
end
