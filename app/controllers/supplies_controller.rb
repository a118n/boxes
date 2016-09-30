class SuppliesController < ApplicationController

  def index
    @supplies = Supply.all.includes(:site)
    if params[:site_id]
      @supplies = Supply.includes(:site).where(site_id: params[:site_id])
      @site = Site.find(params[:site_id])
    end
  end

  def show
    @supply = Supply.includes(:site, :devices).find(params[:id])
  end

  def new
    @supply = Supply.new
    if params[:site_id]
      @supply.site_id = params[:site_id]
    end
  end

  def edit
    @supply = Supply.find(params[:id])
  end

  def create
    @supply = Supply.new(supply_params)
    if @supply.save
      flash[:success] = "Supply added"
      redirect_to @supply
    else
      render 'new'
    end
  end

  def update
    @supply = Supply.find(params[:id])
    if @supply.update_attributes(supply_params)
      flash[:success] = "#{@supply.name} saved"
      redirect_to @supply
    else
      render 'edit'
    end
  end

  def destroy
    Supply.find(params[:id]).destroy
    flash[:warning] = "Supply deleted"
    redirect_to supplies_url
  end

  def assign
    @supply = Supply.find(params[:id])
    @devices = Device.where(site_id: @supply.site_id).order("name")
  end

  private

  def supply_params
    params.require(:supply).permit(:name, :description, :quantity, :threshold,
                                   :site_id, device_ids: [])
  end

end
