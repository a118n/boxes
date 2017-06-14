class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      can :read, Site, id: Site.with_role(:user, user).pluck(:id)
      can [:read, :update, :assign, :all, :create, :export, :destroy], Device, site_id: Site.with_role(:user, user).pluck(:id)
      can [:read, :update, :assign, :history, :all, :create, :export, :destroy], Supply, site_id: Site.with_role(:user, user).pluck(:id)
      can :manage, :static_page
    else
      can [:home, :about], :static_page
    end
  end
end