class DashboardController < ApplicationController
  layout "application"

  def index
  end

  def search
    @search = Homefinder::SearchRequest.retrieve(params[:search])
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
    @search_metadata = @search["data"]["meta"]
    @search_listing = @search["data"]["listings"][0]
  end
end
