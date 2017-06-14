class RegistrationsController < Devise::RegistrationsController

  before_action :authenticate_user!, :redirect_unless_admin,  only: [:new, :create]
  skip_before_action :require_no_authentication

  # def new
  #   flash[:info] = 'Registrations are not allowed. Please contact your administrator.'
  #   redirect_to root_path
  # end
  #
  # def create
  #   flash[:info] = 'Registrations are not allowed. Please contact your administrator.'
  #   redirect_to root_path
  # end

  private
  def redirect_unless_admin
    unless current_user.has_role? :admin
      flash[:error] = "Only admins can do that"
      redirect_to root_path
    end
  end

  def sign_up(resource_name, resource)
    true
  end

end
