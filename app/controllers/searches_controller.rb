class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def index
    @search = Search.new(search_params)
    @search.find

    render partial: "searches/results", search: @search
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end
end
