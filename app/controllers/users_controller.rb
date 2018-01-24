class UsersController < ApplicationController

  before_action :authenticate_user!, :redirect_unless_admin

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_admin_index_path, notice: "User updated"
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:warning] = "User deleted"
    redirect_to users_admin_index_path
  end

  private

  def redirect_unless_admin
    unless current_user.has_role? :admin
      flash[:error] = "Only admins can do that"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
