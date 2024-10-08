# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

# Require RSpec for Rails, webmock and database_cleaner
require 'rspec/rails'
require 'webmock/rspec'
require 'database_cleaner'
require 'pundit/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Load Factory Girl methods
  config.include FactoryBot::Syntax::Methods

  # Configure Database Cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # Configure Shoulda-Matchers
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  VCR.configure do |config|
    config.cassette_library_dir = 'spec/vcr_cassettes'
    config.hook_into :webmock
  end
end