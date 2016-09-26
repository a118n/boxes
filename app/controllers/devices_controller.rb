class DevicesController < ApplicationController

  def index

  end

  def show

  end

  def new

  end

  def edit

  end

  def create

  end

  def update

  end

  def destroy
    Device.find(params[:id]).destroy
  end

  private

  def device_params

  end

end
