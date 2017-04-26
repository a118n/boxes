class SupplyMailer < ApplicationMailer
  def ending_notification(supply)
    @supply = supply
    @users = User.where(site: @supply.site_id).or(User.where(admin: true)).notifiable
    mail(to: @users.map(&:email).uniq, subject: "Supply #{@supply.name} is ending")
  end

  def monthly_usage(month, year, site)
    @month = month
    @year = year
    @site = site
    @users = User.where(site: @supply.site_id).or(User.where(admin: true)).notifiable
    @supplies = Supply.where(site_id: @site.id).all_used
    mail(to: @users.map(&:email).uniq, subject: "Supplies usage in #{@site.name} for #{@month} #{@year}")
  end
end