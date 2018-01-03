$(document).ready(function(){
  let $searchForm = $("#general-search");

  let updateSearchResults = function(response) {
    $resultsContainer = $("#search-results-container")
    $resultsContainer.html(response);
  };

  let disableSearchButton = function(setTo) {
    let $searchFormButton = $("#general-search-button");
    $searchFormButton.prop("disabled", setTo);
  };

  let perform = function(data) {
    disableSearchButton(true)

    let queryData = data || $searchForm.serialize();
    let request = $.ajax({
      type: "GET",
      url: $searchForm.attr("action"),
      data: queryData,
    });

    request.done(updateSearchResults);

    request.complete(function() {
      disableSearchButton(false);
    });
  };

  let submitForm = function(event) {
    event.preventDefault();

    let query = $searchForm.find("#search_query").val()
    if( query != "" ) {
      history.pushState(null, "",`?${$searchForm.serialize()}`);
      perform();
    };
  };

  $(window).bind("popstate", function() {
    let query = location.search.replace("?", "");
    perform(query);
    $("#search_query").val();
  });

  $searchForm.on("submit", submitForm);
});
