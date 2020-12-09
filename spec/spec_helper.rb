# frozen_string_literal: true

require 'bundler/setup'
require 'securerandom'
require 'vcr'
require 'oyi'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Set the OY API configuration
  config.before(:example) do
    Oyi::Client.configure(api_url: 'https://api-stg.oyindonesia.com', api_username: 'xxx', api_key: 'xxx')
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { record: :new_episodes }
end
