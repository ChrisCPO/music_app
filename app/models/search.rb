class Search
  include ActiveModel::Model

  attr_accessor :query

  QUERY_COLUMNS = [
    "songs.title",
    "albums.title",
    "artists.first_name",
    "artists.last_name",
  ]

  def advanced_search_options=(new_options)
    @advanced_options = AdvancedSearchOptions.new(new_options)
  end

  def advanced_options
    @advanced_options ||= AdvancedSearchOptions.new
  end

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
    advanced_options.with_queries do
      Song.joins(:album).joins(:artist).where(full_query, wrapped_query)
    end
  end

  def wrapped_query
    if query.present?
      "%#{query.squish}%"
    end
  end
end
