class SongDecorator < Draper::Decorator
  delegate_all

  def title
    object.title.capitalize
  end

  def rating
    rand(1..10)
  end

  def released_year
    object.release_date.year
  end
end
