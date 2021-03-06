class DevicesController < ApplicationController
  load_and_authorize_resource

  def index
    @site = Site.find(params[:site_id])
    @devices = @site.devices.order("name")
  end

  def all
    @devices = Device.includes(:site).accessible_by(current_ability).order("name")
    redirect_to root_path unless Site.any?
  end

  def show
    @site = Site.find(params[:site_id])
    @device = @site.devices.find(params[:id])
    @device_supplies = @device.supplies.includes(:site).order("name")
    @repairs = @device.repairs.limit(5).order("created_at DESC")
  end

  def new
    @site =  Site.find(params[:site_id])
    @device = @site.devices.build
  end

  def edit
    @site =  Site.find(params[:site_id])
    @device = @site.devices.find(params[:id])
  end

  def create
    @site =  Site.find(params[:site_id])
    @device = @site.devices.build(device_params)
    if @device.save
      flash[:success] = "Device added"
      redirect_to site_devices_path(@site)
    else
      render 'new'
    end
  end

  def update
    @site = Site.find(params[:site_id])
    @device = Device.find(params[:id])
    if @device.update_attributes(device_params)
      flash[:success] = "#{@device.name} saved"
      # Device status changes to 'In Repair'
      if @device.previous_changes.any? && @device.previous_changes["status"][1] == "In Repair"
        redirect_to new_site_device_repair_path(@site, @device)
      # Device status changes from 'In Repair' to something else
      elsif @device.repairs.any? && @device.previous_changes.any? && @device.previous_changes["status"][0] == "In Repair"
        redirect_to edit_site_device_repair_path(@site, @device, @device.repairs.last)
      else
        redirect_to site_device_path(@site, @device)
      end
    else
      render 'edit'
    end
  end

  def destroy
    Device.find(params[:id]).destroy
    flash[:warning] = "Device deleted"
    redirect_to site_devices_path
  end

  def assign
    @site = Site.find(params[:site_id])
    @device = @site.devices.find(params[:id])
    @supplies = @site.supplies.order("name")
  end

  def export
    if params[:repair]
      @devices = Device.includes(:site).in_repair.accessible_by(current_ability)
    elsif params[:all]
      @devices = Device.includes(:site).accessible_by(current_ability)
    else
      @site = Site.find(params[:site_id])
      @devices = @site.devices
    end

    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"Devices.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  private

  def device_params
    params.require(:device).permit(:name, :devtype, :model, :status, :ip,
                                   :location, :sn, :asset_tag, :notes, :site_id,
                                   supply_ids: [])
  end

end
