class SettingsController < ApplicationController
  def edit
    @user = current_user
    @settings = @user.settings
  end

  def update
    @user = current_user
    @settings = @user.settings
    if @settings.update_attributes(settings_params)
      flash[:success] = "Settings saved"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def settings_params
    params.require(:settings).permit(:notifiable, :overview_limit)
  end
end
