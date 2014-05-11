class DashboardController < ApplicationController
  def index
  end

  def search
    @search = Homefinder::SearchRequest.retrieve(params[:search])
  end
end
