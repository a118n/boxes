class DevicesController < ApplicationController

  def index
    @devices = Device.all.includes(:site)
    if params[:site_id]
      @devices = Device.includes(:site).where(site_id: params[:site_id])
      @site = Site.find(params[:site_id])
    end
  end

  def show
    @device = Device.includes(:site, :supplies).find(params[:id])
  end

  def new
    @device = Device.new
    if params[:site_id]
      @device.site_id = params[:site_id]
    end
  end

  def edit
    @device = Device.find(params[:id])
  end

  def create
    @device = Device.new(device_params)
    if @device.save
      flash[:success] = "Device added"
      redirect_to @device
    else
      render 'new'
    end
  end

  def update
    @device = Device.find(params[:id])
    if @device.update_attributes(device_params)
      flash[:success] = "#{@device.name} saved"
      redirect_to @device
    else
      render 'edit'
    end
  end

  def destroy
    Device.find(params[:id]).destroy
    flash[:warning] = "Device deleted"
    redirect_to devices_url
  end

  def assign
    @device = Device.find(params[:id])
    @supplies = Supply.where(site_id: @device.site_id).order("name")
  end

  private

  def device_params
    params.require(:device).permit(:name, :devtype, :model, :state, :ip,
                                   :location, :sn, :site_id, supply_ids: [])
  end

end
