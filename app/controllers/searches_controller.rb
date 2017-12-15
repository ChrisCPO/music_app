class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    @search.find

    render :show
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end
end
