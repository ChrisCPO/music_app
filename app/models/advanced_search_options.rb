class AdvancedSearchOptions
  include ActiveModel::Model

  BLANK_QUERY = ""

  attr_accessor :release_year, :rating

  def with_queries
    yield.where(*release_year_query).where(rating_query)
  end

  private

  def release_year_query
    if release_year.present?
      ["extract(year from release_date) = ?", release_year]
    else
      [BLANK_QUERY]
    end
  end

  def rating_query
    if rating.present?
      { rating: rating }
    else
      BLANK_QUERY
    end
  end
end
