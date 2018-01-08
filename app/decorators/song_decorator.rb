class SongDecorator < Draper::Decorator
  delegate_all

  def title
    object.title.capitalize
  end

  def rating
    rand(1..10)
  end

  def released
    rand(1945...Date.current.year)
  end
end
