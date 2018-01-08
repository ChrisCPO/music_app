module Features
  module SearchHelper
    def results_text(count: ,query:)
      text_options = {
        length: count,
        for: query,
        results_word: "result".pluralize(count)
      }

      I18n.t("searches.show.results_length", text_options)
    end
  end
end
