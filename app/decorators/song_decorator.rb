class SongDecorator < Draper::Decorator
  delegate_all

  def released_year
    object.release_date.year
  end
end
