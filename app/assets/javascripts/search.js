$(document).ready(function(){
  let $searchForm = $("#general-search");
  let $advancedOptions = $("#adv-search-options");
  let $advancedOptionsForm = $("#adv-search-options-form");

  let advancedOptionsData = function() {
    let form = $advancedOptionsForm.serialize().match(/&search(.*)/g)[0];
    return form;
  };

  let formData = function(){
    let data =  $searchForm.serialize() + advancedOptionsData();
    return data;
  };

  let updateSearchResults = function(response) {
    $advancedOptions.show()
    $resultsContainer = $("#search-results")
    $resultsContainer.html(response);
  };

  let disableSearchButton = function(setTo) {
    let $searchFormButton = $("#general-search-button");
    $searchFormButton.prop("disabled", setTo);
  };

  let perform = function(data) {
    disableSearchButton(true)

    let queryData = data || formData()
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
      let newUrl = `/searches?${formData()}`

      if (!window.location.href.includes("/searches")) {
        window.location = newUrl
      } else {
        history.pushState(null, "", newUrl);
        perform();
      }
    };
  };

  $(window).bind("popstate", function() {
    let query = location.search.replace("?", "");
    perform(query);
  });

  $searchForm.on("submit", submitForm);
});
