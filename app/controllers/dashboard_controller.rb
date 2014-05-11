class DashboardController < ApplicationController
  layout "application"

  def index
  end

  def search
    @search = Homefinder::SearchRequest.retrieve(params[:search])
    @search_metadata = @search["data"]["meta"]
    @search_listings = @search["data"]["listings"]
  end
end
