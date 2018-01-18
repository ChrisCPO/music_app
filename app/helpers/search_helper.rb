module SearchHelper
  def search_form
    @search || Search.new
  end

  def show_advanced_options
    !@search.results? || @search.advanced_search_options.has_attributes?
  end

  def results_text(search)
    count = search.results.count

    text_options = {
      length: count,
      for: search.query,
      results_word: "result".pluralize(count)
    }
    t("searches.index.results_length", text_options)
  end
end
