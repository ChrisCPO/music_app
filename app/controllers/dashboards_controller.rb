class DashboardsController < ApplicationController
  def show
    artists = Artist.trending
    @dashboard = Dashboard.new(trending_artists: artists)
  end
end
