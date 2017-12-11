class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @search = Search.new
    @search.find(search_params)

    render :show
  end

  private

  def search_params
    params[:query]
  end
end
