# frozen_string_literal: true

require 'pry-byebug'

module SpecHelpers
  module SetMonkeyAction
    def force_action(action)
      @action = action
    end
  end
end

# Use :should in stead of :expect
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :should
  end
  config.mock_with :rspec do |c|
    c.syntax = :should
  end
  # config.raise_errors_for_deprecations!
end
