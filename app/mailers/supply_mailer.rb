class SupplyMailer < ApplicationMailer
  def ending_notification(supply)
    @users = User.joins(:settings).where(settings: { notifiable: true })
    @supply = supply
    @users.each do |user|
      mail(to: user.email, subject: "Supply #{@supply.name} is ending")
    end
  end
end