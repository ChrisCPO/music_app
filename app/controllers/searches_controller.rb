class SearchesController < ApplicationController
  def index
    if search_params
      search_results
    else
      @search = Search.new
    end
  end

  def results
    search_results

    render partial: "searches/results", search: @search
  end

  private

  def search_results
    @search = Search.new(search_params)
    @search.find
    @search.decorate_results
  end

  def search_params
    if params[:search]
      params.require(:search).permit(:query, advanced_search_options: [:rating, :release_year])
    end
  end
end
