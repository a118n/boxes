class SitesController < ApplicationController
  load_and_authorize_resource

  def index
    @sites = Site.accessible_by(current_ability).order("name")
    if @sites.empty?
      redirect_to root_path
    end
  end

  def show
    @site = Site.includes(:devices, :supplies).find(params[:id])
    @site_devices = @site.devices
    @site_supplies = @site.supplies
  end

  def new
    @site = Site.new
  end

  def edit
    @site = Site.find(params[:id])
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      flash[:success] = "Site added"
      redirect_to @site
    else
      render 'new'
    end
  end

  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(site_params)
      flash[:success] = "#{@site.name} saved"
      redirect_to @site
    else
      render 'edit'
    end
  end

  def destroy
    Site.find(params[:id]).destroy
    flash[:warning] = "Site deleted"
    redirect_to sites_path
  end

  private

  def site_params
    params.require(:site).permit(:name, :location, :description)
  end

end
