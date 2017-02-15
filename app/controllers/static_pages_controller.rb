class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
      redirect_to overview_path
    end
  end

  def overview
    @sites = Site.all
    @devices = Device.all
    @supplies = Supply.all
    @primary_site =  current_user.settings.primary_site
    @overview_limit = current_user.settings.overview_limit
    if @primary_site.nil?
      @supplies_ending = Supply.includes(:site).ending_soon
                                               .limit(@overview_limit)
      @supplies_most_used = Supply.includes(:site).most_used
                                                  .limit(@overview_limit)
      @devices_repair = Device.includes(:site).in_repair
    else
      @primary_site_name = Site.find(@primary_site).name
      @supplies_ending = Supply.includes(:site).where(site_id: @primary_site)
                                               .ending_soon
                                               .limit(@overview_limit)
      @supplies_most_used = Supply.includes(:site).where(site_id: @primary_site)
                                                  .most_used
                                                  .limit(@overview_limit)
      @devices_repair = Device.includes(:site).where(site_id: @primary_site)
                                              .in_repair
    end
  end

  def about
  end

  def search
    @results = Searchkick.search(params[:query],
                                 fields: [:name, :model, :location, :sn,
                                          :description],
                                 match: :word_middle).results
  end

  def reports
    @start_year = (Version.first.try(:created_at) || Date.today).year
    if params[:report_date]
      @site = params[:site_id][:site_id]
      @month = params[:report_date][:month]
      @month_name = Date::MONTHNAMES[@month.to_i]
      @year = params[:report_date][:year]
      @versions = Version.where(site_id: @site).includes(:supply).by_year(@year).by_month(@month)
      @pie_chart_data =  @versions.map { |v| [v.supply.name, v.used] }.to_h
    end
  end

end