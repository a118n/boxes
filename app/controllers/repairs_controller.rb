class RepairsController < ApplicationController
  load_and_authorize_resource

  def index
    @device = Device.find(params[:device_id])
    @repairs = @device.repairs.order("created_at DESC")
  end

  def show
    @device = Device.find(params[:device_id])
    @repair = Repair.find(params[:id])
  end

  def new
    @site = Site.find(params[:site_id])
    @device = Device.find(params[:device_id])
    @repair = @device.repairs.build
  end

  def edit
    @site = Site.find(params[:site_id])
    @device = Device.find(params[:device_id])
    @repair = Repair.find(params[:id])
  end

  def create
    @site = Site.find(params[:site_id])
    @device = Device.find(params[:device_id])
    @repair = @device.repairs.build(repair_params)
    if @repair.save
      redirect_to site_device_path(@site, @device), notice: 'Repair was successfully created.'
    else
      render :new
    end
  end

  def update
    @site = Site.find(params[:site_id])
    @device = Device.find(params[:device_id])
    if @repair.update(repair_params)
      redirect_to site_device_path(@site, @device), notice: 'Repair was successfully saved.'
    else
      render :edit
    end
  end

  private
    def repair_params
      params.require(:repair).permit(:status, :description, :ticket_id, :device_id)
    end
end
