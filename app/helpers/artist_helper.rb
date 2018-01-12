module ArtistHelper
  def profile_image_source_link(artist)
    "http://avatar.baccano.io/#{artist.full_name}"
  end
end
