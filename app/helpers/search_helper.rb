module SearchHelper
  def search_form
    @search || Search.new
  end

  def results_text(search)
    count = search.results.count

    text_options = {
      length: count,
      for: search.query,
      results_word: pluralize(count, "result")
    }
    t("searches.show.results_length", text_options)
  end
end
