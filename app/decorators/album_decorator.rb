class AlbumDecorator < Draper::Decorator
  delegate_all

  def rating
    rand(1..10)
  end

  def released
    rand(1945...Date.current.year)
  end
end
