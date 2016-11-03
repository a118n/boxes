class SupplyMailer < ApplicationMailer
  def ending_notification(supply)
    @supply = supply
    @users = User.joins(:settings).where(settings: { notifiable: true })
    @users.each do |user|
      mail(to: user.email, subject: "Supply #{@supply.name} is ending")
    end
  end

  def monthly_usage(month, year)
    @month = month
    @year = year
    # Get all the supplies using scope defined in Model
    @supplies = Supply.most_used
    @users = User.joins(:settings).where(settings: { notifiable: true })
    @users.each do |user|
      mail(to: user.email, subject: "Supplies usage for #{@month} #{@year}")
    end
  end
end