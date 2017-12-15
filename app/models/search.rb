class Search
  include ActiveModel::Model
  attr_writer :results
  attr_accessor :query

  def find
    @results = find_results
  end

  def results
    @results ||= []
  end

  private

  def find_results
    Song.where("title ILIKE ?", wrapped_query)
  end

  def wrapped_query
    if query.present?
      "%#{query}%"
    end
  end
end
