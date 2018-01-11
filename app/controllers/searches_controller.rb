class SearchesController < ApplicationController
  def index
    if search_params
      @search = Search.new(search_params)
      @search.find
    else
      @search = Search.new
    end
  end

  def results
    @search = Search.new(search_params)
    @search.find

    render partial: "searches/results", search: @search
  end

  private

  def search_params
    if params[:search]
      params.require(:search).permit(:query, advanced_search_options: [:rating, :release_year])
    end
  end
end
