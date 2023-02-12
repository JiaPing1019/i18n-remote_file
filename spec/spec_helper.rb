# frozen_string_literal: true

require 'i18n/remote_file'
require './spec/support/i18n_helper'
require './spec/support/vcr_config'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.include I18nHelper
  config.include VcrConfig

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
