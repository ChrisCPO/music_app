class Search
  include ActiveModel::Model
  attr_writer :results
  attr_reader :query

  def find(query)
    self.query = query
    self.results = find_results
  end

  def query=(query)
    @query = "%#{query}%"
  end

  def results
    @results ||= []
  end

  private

  def find_results
    Song.where("title ILIKE ?", query)
  end
end
