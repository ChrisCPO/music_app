class Search
  include ActiveModel::Model

  attr_accessor :query

  LIMIT = 20
  QUERY_COLUMNS = [
    "songs.title",
    "albums.title",
    "artists.first_name",
    "artists.last_name",
  ]

  def advanced_search_options=(new_options)
    @advanced_options = AdvancedSearchOptions.new(new_options)
  end

  def advanced_search_options
    @advanced_options ||= AdvancedSearchOptions.new
  end

  def find
    @results = find_results
    @results
  end

  def results
    @results ||= []
  end

  def results?
    results.any?
  end

  def decorate_results
    @results = SongDecorator.decorate_collection(@results)
  end

  private

  def find_results
    ilike = " ILIKE ?"
    query_colums = QUERY_COLUMNS.join(" || ' ' || ")
    full_query = query_colums + ilike

    advanced_search_options.with_queries do
      Song.joins(:album).joins(:artist).
        where(full_query, wrapped_query).
        order("position('#{string_query}' in #{query_colums}) ASC").
        limit(LIMIT)
    end
  end

  def wrapped_query
    if query.present?
      "%#{prepared_query}%"
    end
  end

  def string_query
    prepared_query.gsub("'", "''")
  end

  def prepared_query
    @query.squish
  end
end
