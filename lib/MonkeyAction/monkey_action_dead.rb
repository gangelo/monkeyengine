# frozen_string_literal: true

require_relative 'monkey_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  dead (as in not alive)
# The monkey has been killed - the thread is not running.
class MonkeyActionDead < MonkeyAction
  WEIGHT = 100.0
  VALID_VALUES = [true].freeze

  def initialize(monkey)
    super monkey, true, WEIGHT

    validate
  end

  protected

  def validate
    super

    raise MonkeyEngine::Exceptions::InvalidArgumentValueException, "Value '#{value}' is not a valid value" \
      unless VALID_VALUES.include?(@value)
  end
end
