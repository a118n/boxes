class SupplyMailer < ApplicationMailer
  def ending_notification(supply)
    @supply = supply
    @role = @supply.site.roles.first
    @admin_role = Role.find_by(name: "admin")
    @users = User.joins(:users_roles).where(users_roles: { role_id: @role.id }).notifiable

    mail(to: @users.map(&:email).uniq, subject: "Supply #{@supply.name} is ending")
  end

  def monthly_usage(month, year, site)
    @month = month
    @year = year
    @site = site
    @supplies = Supply.where(site_id: @site.id).all_used
    @role = @site.roles.first
    @admin_role = Role.find_by(name: "admin")
    @users = User.joins(:users_roles).where(users_roles: { role_id: [ @role.id, @admin_role.id ] }).notifiable

    mail(to: @users.map(&:email).uniq, subject: "Supplies usage in #{@site.name} for #{@month} #{@year}")
  end
end
