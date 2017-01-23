class SuppliesController < ApplicationController

  def index
    @site = Site.includes(:supplies).find(params[:site_id])
    @supplies = @site.supplies
  end

  def all
    @supplies = Supply.all.includes(:site)
    redirect_to root_path unless Site.any?
  end

  def show
    @site = Site.find(params[:site_id])
    @supply = @site.supplies.find(params[:id])
    @supply_devices = @supply.devices.includes(:site)
  end

  def new
    @site =  Site.find(params[:site_id])
    @supply = @site.supplies.build
  end

  def edit
    @site =  Site.find(params[:site_id])
    @supply = @site.supplies.find(params[:id])
  end

  def create
    @site =  Site.find(params[:site_id])
    @supply = @site.supplies.build(supply_params)
    if @supply.save
      flash[:success] = "Supply added"
      redirect_to site_supply_path(@site, @supply)
    else
      render 'new'
    end
  end

  def update
    @site = Site.find(params[:site_id])
    @supply = @site.supplies.find(params[:id])

    if params[:withdraw]
      if @supply.quantity == 0
        flash[:danger] = "Supply quantity is already 0"
        redirect_to site_supply_path(@site, @supply)
      else
        @supply.quantity -= 1
        @supply.save
        flash[:warning] = "#{@supply.name} quantity has changed to: #{@supply.quantity}"
        redirect_to site_supply_path(@site, @supply)
        notify
      end

    else
      if @supply.update_attributes(supply_params)
        flash[:success] = "#{@supply.name} saved"
        # Needed for changing Site in form, for site_id to be updated for the redirect
        @supply.reload
        redirect_to site_supply_path(@supply.site, @supply)
        notify
      else
        render 'edit'
      end
    end
  end

  def destroy
    Supply.find(params[:id]).destroy
    flash[:warning] = "Supply deleted"
    redirect_to site_supplies_path
  end

  def assign
    @site = Site.find(params[:site_id])
    @supply = @site.supplies.find(params[:id])
    @devices = @site.devices.order("name")
  end

  def export
    if params[:ending]
      @supplies = Supply.includes(:site).ending_soon
    elsif params[:most_used]
      @supplies = Supply.includes(:site).most_used
    elsif params[:all]
      @supplies = Supply.includes(:site).all
    else
      @site = Site.find(params[:site_id])
      @supplies = @site.supplies
    end

    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"Supplies.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def history
    @site = Site.find(params[:site_id])
    @supply = @site.supplies.find(params[:id])
    @start_year = (@supply.versions.first.try(:created_at) || Date.today).year
    if params[:report_date]
      @year = params[:report_date][:year]
      @versions = @supply.versions.by_year(@year).order("created_at DESC")
      @pie_chart_data =  @versions.map { |v| [v.created_at.strftime("%B"), v.used] }.to_h
    end
  end

  private

  def notify
    if @supply.quantity <= @supply.threshold && !@supply.notified
      SupplyMailer.ending_notification(@supply).deliver_later
      @supply.update_attribute(:notified, true)
    elsif @supply.quantity > @supply.threshold && @supply.notified
      @supply.update_attribute(:notified, false)
    end
  end

  def supply_params
    params.require(:supply).permit(:name, :description, :quantity, :threshold,
                                   :site_id, device_ids: [])
  end

end