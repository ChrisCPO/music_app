class SongsController < ApplicationController
  def show
    @song = Song.find(params[:id]).decorate
  end
end
