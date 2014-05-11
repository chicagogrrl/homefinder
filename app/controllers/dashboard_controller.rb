class DashboardController < ApplicationController
  layout "application"

  def index
  end

  def search
    if params[:search].try(:[], :area).blank?
      redirect_to root_path, flash: {error: "No city or ZIP code was provided. Please search again."} and return
    end

    @search = Homefinder::SearchRequest.retrieve(params[:search])
    if @search["data"].blank?
      redirect_to root_path, flash: {error: "No listings match your criteria. Please try again."} and return
    end

    @search_metadata = @search["data"]["meta"]
    @search_listings = @search["data"]["listings"]
    @search_options = params[:search].merge(page: @search_metadata["currentPage"].to_i)

    @start_num = @search_options["page"] == 1 ? 1 : @search_options["page"] * 20

    @end_num = if @search_metadata["totalMatched"].to_i > 20 * @search_options["page"]
      @start_num == 1 ? 20 : @start_num + 20
    else
      @search_metadata["totalMatched"]
    end
  end

  def show
    @search = Homefinder::SearchRequest.retrieve_single(params[:id])
    if @search["data"].blank?
      redirect_to root_path, flash: {error: "Listing not found."} and return
    end

    @search_metadata = @search["data"]["meta"]
    @search_listing = @search["data"]["listings"][0]
  end
end
