ENV["RACK_ENV"] = "test"

require File.expand_path("../../config/environment", __FILE__)
abort("DATABASE_URL environment variable is set") if ENV["DATABASE_URL"]

require "rspec/rails"
require 'capybara-screenshot/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |file| require file }

# Extend this module in spec/support/features/*.rb
module Features
  include Formulaic::Dsl
  include Features::SearchHelper
  include Features::JavaScriptHelpers
end

module FactoryHelpers
  include NameGenerator
  include DateHelpers
end
FactoryGirl::SyntaxRunner.send(:include, FactoryHelpers)

RSpec.configure do |config|
  config.include Features, type: :feature
  config.include FactoryHelpers
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
end

ActiveRecord::Migration.maintain_test_schema!
