# frozen_string_literal: true

require_relative 'monkey_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  wake (as in from sleep)
# The monkey has awakened from sleep.
class MonkeyActionWake < MonkeyAction
  WEIGHT = 2.0
  VALID_VALUES = [true].freeze

  def initialize(monkey)
    super(monkey, true, WEIGHT)

    validate
  end

  protected

  def validate
    super

    raise MonkeyEngine::Exceptions::InvalidArgumentValueException, "Value '#{value}' is not a valid value" \
      unless VALID_VALUES.include?(@value)
  end
end
