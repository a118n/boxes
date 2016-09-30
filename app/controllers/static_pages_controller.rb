class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to overview_path
    end
  end

  def overview
    @supplies_ending = Supply.includes(:site).ending_soon.order("quantity")
    @devices_repair = Device.includes(:site).in_repair.order("name")
    @sites = Site.all
    @devices = Device.all
    @supplies = Supply.all
  end

  def about
  end

  def settings
  end
end
