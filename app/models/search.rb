class Search
  include ActiveModel::Model

  attr_accessor :query

  QUERY_COLUMNS = [
    "songs.title",
    "albums.title",
    "artists.first_name",
    "artists.last_name",
  ]

  def find
    @results = find_results
  end

  def results
    @results ||= []
  end

  def results?
    results.any?
  end

  private

  def find_results
    ilike = " ILIKE ?"
    full_query = QUERY_COLUMNS.join(" || ' ' || ") + ilike
    Song.joins(:album).joins(:artist).where(full_query, wrapped_query)
  end

  def wrapped_query
    if query.present?
      "%#{query.squish}%"
    end
  end
end
