class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to overview_path
    end
  end

  def overview
    @sites = Site.all
    @devices = Device.all
    @supplies = Supply.all
    @primary_site =  current_user.settings.primary_site
    if @primary_site.nil?
      @supplies_ending = Supply.includes(:site).ending_soon.order("quantity")
      @supplies_most_used = Supply.includes(:site).most_used
      @devices_repair = Device.includes(:site).in_repair.order("name")
    else
      @primary_site_name = Site.find(@primary_site).name
      @supplies_ending = Supply.includes(:site).where(site_id: @primary_site).ending_soon.order("quantity")
      @supplies_most_used = Supply.includes(:site).where(site_id: @primary_site).most_used
      @devices_repair = Device.includes(:site).where(site_id: @primary_site).in_repair.order("name")
    end
  end

  def about
  end

end
