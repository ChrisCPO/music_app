class AlbumDecorator < Draper::Decorator
  delegate_all

  def released
    rand(1945...Date.current.year)
  end
end
