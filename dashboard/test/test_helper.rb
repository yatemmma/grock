if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'test'
    command_name 'Mintest'
  end
end

require 'bundler/setup'
require 'minitest/autorun'
require 'minitest-power_assert'

require 'factory_girl'
require 'database_cleaner'
FactoryGirl.definition_file_paths = %w{test/factories}
