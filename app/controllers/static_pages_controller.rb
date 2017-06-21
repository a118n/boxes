class StaticPagesController < ApplicationController
  authorize_resource class: false

  def home
    if user_signed_in?
      redirect_to overview_path
    end
  end

  def overview
    @sites = Site.accessible_by(current_ability).order("name")
    @devices = Device.accessible_by(current_ability)
    @supplies = Supply.accessible_by(current_ability)
    @overview_limit = current_user.settings.overview_limit
    @supplies_ending = Supply.includes(:site).ending_soon
                                             .accessible_by(current_ability)
                                             .limit(@overview_limit)
    @supplies_most_used = Supply.includes(:site).most_used
                                                .accessible_by(current_ability)
                                                .limit(@overview_limit)
    @devices_repair = Device.includes(:site).in_repair
                                            .accessible_by(current_ability)
  end

  def about
  end

  def search
    @devices = Device.search(params[:query],
                             fields: ["name^10", "model", "location", "sn", "description"],
                             match: :word_middle).records.accessible_by(current_ability)

    @supplies = Supply.search(params[:query],
                              fields: ["name^10", "description"],
                              match: :word_middle).records.accessible_by(current_ability)

    @results = @devices + @supplies
  end

end
