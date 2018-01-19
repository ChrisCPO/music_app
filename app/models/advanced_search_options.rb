class AdvancedSearchOptions
  include ActiveModel::Model

  BLANK_QUERY = ""
  ATTRS = [:release_year, :rating]

  attr_accessor(*ATTRS)

  def with_queries
    yield.where(*release_year_query).where(rating_query)
  end

  def attributes
    @attributes ||= {}
    build_attributes
    @attributes
  end

  def has_attributes?
    attributes.to_a.select{|_,v| v }.any?
  end

  private

  def release_year_query
    if release_year.present?
      ["extract(year from release_date) = ?", release_year.to_i]
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

  def build_attributes
    ATTRS.each do |attr|
      @attributes[attr] = send(attr)
    end
  end
end
