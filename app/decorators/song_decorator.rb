class SongDecorator < Draper::Decorator
  delegate_all

  def short_rating
    "#{rating} / #{Rating::MAX}"
  end

  def released_year
    object.release_date.year
  end
end
