class SearchesController < ApplicationController
  def new
    if search_params
      @search = Search.new(search_params)
      @search.find
      render :index
    end
    @search = Search.new
  end

  def index
    @search = Search.new(search_params)
    @search.find

    render partial: "searches/results", search: @search
  end

  private

  def search_params
    if params[:search]
      params.require(:search).permit(:query)
    end
  end
end
