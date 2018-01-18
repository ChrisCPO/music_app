$(document).ready(function(){
  var $searchForm = $("#general-search");
  var $advancedOptions = $("#adv-search-options");
  var $advancedOptionsForm = $("#adv-search-options-form");

  var advancedOptionsData = function() {
    var form = $advancedOptionsForm.serialize().match(/&search(.*)/g);
    if (form) {
      return form[0];
    } else {
      return "";
    }
  };

  var formData = function(){
    var data =  $searchForm.serialize() + advancedOptionsData();
    return data;
  };

  var updateSearchResults = function(response) {
    $advancedOptions.show();
    $resultsContainer = $("#search-results");
    $resultsContainer.html(response);
  };

  var disableSearchButton = function(setTo) {
    var $searchFormButton = $("#general-search-button");
    $searchFormButton.prop("disabled", setTo);
  };

  var perform = function(data) {
    disableSearchButton(true);

    var queryData = data || formData();
    var request = $.ajax({
      type: "GET",
      url: $searchForm.attr("action"),
      data: queryData
    });

    request.done(updateSearchResults);

    request.complete(function() {
      disableSearchButton(false);
    });
  };

  var submitForm = function(event) {
    event.preventDefault();
    var query = $searchForm.find("#search_query").val();

    if ( query != "" ) {
      var newUrl = "/searches?" + formData();

      var userIsSearching = window.location.pathname == "/searches";
      if (userIsSearching) {
        history.pushState(null, "", newUrl);
        perform();
      } else {
        window.location.href = newUrl;
      }
    };
  };

  $(window).bind("popstate", function() {
    var query = location.search.replace("?", "");
    perform(query);
  });

  $searchForm.on("submit", submitForm);
  $advancedOptions.on("keypress", function(event) {
    var enterKey = 13;
    if (event.which == enterKey) {
      submitForm(event);
    }
  });
});
