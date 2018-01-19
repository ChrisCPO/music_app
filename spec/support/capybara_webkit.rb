Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
  config.raise_javascript_errors = true
end
