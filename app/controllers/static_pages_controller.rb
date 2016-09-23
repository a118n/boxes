class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to overview_path
    end
  end

  def overview
    @supplies_ending = Supply.ending_soon.order("quantity")
    @devices_repair = Device.in_repair.order("name")
    @sites = Site.all.includes(:devices, :supplies)
    @devices = Device.all
    @supplies = Supply.all
  end

  def about
  end

  def settings
  end
end
