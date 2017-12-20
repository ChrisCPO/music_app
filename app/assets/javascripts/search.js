$(document).ready(function(){
  var $searchForm = $("#general-search");

  var updateSearchResults = function(response) {
    $resultsContainer = $("#search-results-container")
    $resultsContainer.html(response);
  };

  var disableSearchButton = function(setTo) {
    var $searchFormButton = $("#general-search-button");
    $searchFormButton.prop("disabled", setTo);
  };

  var perform = function() {
    disableSearchButton(true)

    var request = $.ajax({
      type: "GET",
      url: $searchForm.attr("action"),
      data: $searchForm.serialize(),
    });

    request.done(updateSearchResults);

    request.complete(function() {
      disableSearchButton(false);
    });
  };

  var submitForm = function(event) {
    event.preventDefault();

    let query = $searchForm.find("#search_query").val()
    if( query != "" ) {
      perform()
    };
  };

  $searchForm.on("submit", submitForm);
});
