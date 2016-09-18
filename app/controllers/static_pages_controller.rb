class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to overview_path
    end
  end

  def overview
  end

  def about
  end
end
