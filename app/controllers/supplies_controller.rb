class SuppliesController < ApplicationController

  def index
    @supplies = Supply.all
  end

  def show
    @supply = Supply.find(params[:id])
  end

  def new
    @supply = Supply.new
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

  private

  def supply_params
    params.require(:supply).permit(:name, :description, :quantity, :threshold,
                                   :site_id)
  end

end
